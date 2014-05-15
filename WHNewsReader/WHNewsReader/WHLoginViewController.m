//
//  WHLoginViewController.m
//  WHNewsReader
//
//  Created by Kelly Galuska on 5/13/14.
//
//

#import "WHLoginViewController.h"
#import "WHLoginView.h"

@interface WHLoginViewController ()
@property WHLoginView *loginView;
@property NSString *username;
@property NSString *password;
@property NSOperationQueue *operationQueue;
@end

@implementation WHLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    //self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([WHLoginView class]) owner:nil options:nil][0];
    if (self) {
        // Custom initialization
    }
    _loginView = [[WHLoginView alloc] init];
    [self.view addSubview:_loginView];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _operationQueue = [[NSOperationQueue alloc] init];
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
    _username = [_loginView getUsername];
    _password = [_loginView getPassword];
    NSString *loginString = [NSString stringWithFormat:@"{\"username\": \"%@\",\"password\": \"%@\"}" ,_username, _password];
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


@end
