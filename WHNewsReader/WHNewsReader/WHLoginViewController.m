//
//  WHLoginViewController.m
//  WHNewsReader
//
//  Created by Kelly Galuska on 5/13/14.
//
//

#import "WHLoginViewController.h"
#import "WHUserObject.h"
#import "WHLoginObject.h"
#import "WHDataRetrieval.h"

@interface WHLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property NSOperationQueue *operationQueue;

@property WHUserObject *userData;
@property WHLoginObject *loginData;
@end

@implementation WHLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    //self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([WHLoginView class]) owner:nil options:nil][0];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _operationQueue = [[NSOperationQueue alloc] init];
    _userData = [[WHUserObject alloc] init];
    _loginData = [[WHLoginObject alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didSelectGo:(id)sender
{
    [self.view endEditing:YES];
    [self makeRequest];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    [self makeRequest];
    return YES;
}

- (void)makeRequest
{
    [self login];
}

- (void)login
{
    //Create url
    NSURL *url = [NSURL URLWithString:@"https://mobileweb.caps.ua.edu/cs491/api/Account/login"];
    
    //Create request object
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:5.0];
    //Let the server know we want JSON
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //Set http method
    [request setHTTPMethod:@"POST"];
    
    //Specify the string to get sent to the server
    NSString *username = _usernameTextField.text;
    NSString *password = _passwordTextField.text;
    NSString *loginString = [NSString stringWithFormat:@"{\"username\": \"%@\",\"password\": \"%@\"}" ,username, password];
    //NSString *loginString = @"{\"username\": \"zbarnes\",\"password\": \"password\"}";
    //Make that string into raw data
    NSData *loginData = [loginString dataUsingEncoding:NSUTF8StringEncoding];
    //Set raw data as the HTTP Body
    [request setHTTPBody:loginData];
    
    //Send asynchronous request
    [NSURLConnection sendAsynchronousRequest:request queue:_operationQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        //Decode to string
        NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //Log out response
        NSLog(@"%@", responseString);
    }];
}

- (void) parseJSONtoObjects:(NSData *)responseData
{
    if(responseData == nil)
        return;
    NSError *error;
    NSMutableDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
    NSLog([dataDictionary objectForKey:@"accessToken"]);
    NSLog([dataDictionary objectForKey:@"Id"]);
    NSLog([dataDictionary objectForKey:@"firstName"]);
    NSLog([dataDictionary objectForKey:@"lastName"]);
    NSLog([dataDictionary objectForKey:@"username"]);
    NSLog([dataDictionary objectForKey:@"email"]);
    NSLog([dataDictionary objectForKey:@"position"]);
    NSLog([dataDictionary objectForKey:@"isWriter"]);
    NSLog([dataDictionary objectForKey:@"imageUrl"]);
}


@end
