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
#import "WHRecentTableViewController.h"
#import "WHSearchTableViewController.h"
#import "WHCategoryTableViewController.h"

@interface WHLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property NSOperationQueue *operationQueue;
@property BOOL isSuccessful;
@property WHUserObject *userData;
@property WHLoginObject *loginData;
@end

@implementation WHLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"WHLoginViewController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _isSuccessful = NO;
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
    [self login];
}

-(void) createTabBar
{
    _tabBarController = [[UITabBarController alloc] init];
    
    //UINavigationController *loginNav = [[UINavigationController alloc] initWithRootViewController:self];
                                        
    WHSearchTableViewController *searchController = [[WHSearchTableViewController alloc] init];
    searchController.title = @"Search Stories";
    UINavigationController *searchNavController = [[UINavigationController alloc] initWithRootViewController:searchController];
    
    WHRecentTableViewController *recentController = [[WHRecentTableViewController alloc] init];
    recentController.title = @"Recent Stories";
    recentController.tabBarItem.image = [UIImage imageNamed:@"recent-25.png"];
    UINavigationController *recentNavController = [[UINavigationController alloc] initWithRootViewController:recentController];
    
    WHCategoryTableViewController *categoryController =[[WHCategoryTableViewController alloc] initWithCats];
    categoryController.title=@"Search By Category";
    UINavigationController *catNavController = [[UINavigationController alloc] initWithRootViewController:categoryController];
    
    [_tabBarController setViewControllers:@[recentNavController, searchNavController, catNavController]];
    
    //[loginNav pushViewController:tabBarController animated:YES];
    [self.window setRootViewController:_tabBarController];
//    [self presentViewController:_tabBarController animated:YES completion:nil];
    
    
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

-(BOOL) isLoginSuccessful
{
    if(_isSuccessful == YES)
        return YES;
    else
        return NO;
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
    NSString *loginString = [NSString stringWithFormat:@"{\"username\": \"%@\",\"password\": \"%@\"}" , username, password];
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
//        if(![responseString  isEqual: @"null"]) {
//            _isSuccessful = YES;
//        }
        if(([responseString rangeOfString:@"\"accessToken\":null"].location == NSNotFound))
        {
            _isSuccessful = YES;
        }
        //[self parseJSONtoObjects:loginData];
        NSData *responseData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
        [self parseJSONtoObjects:responseData];
        
        if(_isSuccessful == YES) {
            //NSLog(@"%hhd", _isSuccessful);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self createTabBar];

            });
            
        }
    }];
    if(_isSuccessful == NO)
        [self failLogin];
    
}

- (void) failLogin
{
    UILabel *failed = [[UILabel alloc] initWithFrame:CGRectMake(5, 200, 300, 50)];
    failed.text = @"Incorrect username or password.";
    failed.textColor = [UIColor redColor];
    [self.view addSubview:failed];
}

- (void)parseJSONtoObjects:(NSData *)responseData
{
    if(responseData == NULL)
        return;
    NSError *error;
    NSMutableDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
    NSDictionary *userDictionary = [dataDictionary objectForKey:@"user"];
    _loginData.accessToken = [dataDictionary objectForKey:@"accessToken"];
    _userData.Id = [userDictionary objectForKey:@"Id"];
    _userData.firstName = [userDictionary objectForKey:@"firstName"];
    _userData.lastName = [userDictionary objectForKey:@"lastName"];
    _userData.username = [userDictionary objectForKey:@"username"];
    _userData.email = [userDictionary objectForKey:@"email"];
    _userData.position = [userDictionary objectForKey:@"position"];
    _userData.isWriter = [userDictionary objectForKey:@"isWriter"];
    _userData.imageUrl = [userDictionary objectForKey:@"imageURL"];
    _loginData.user = _userData;
    [WHDataRetrieval setUserToken:_loginData.accessToken];
    
    //NSLog([dataDictionary objectForKey:@"accessToken"]);
    //NSLog([userDictionary objectForKey:@"Id"]);
    //NSLog([userDictionary objectForKey:@"firstName"]);
    //NSLog([userDictionary objectForKey:@"lastName"]);
    //NSLog([userDictionary objectForKey:@"username"]);
    //NSLog([userDictionary objectForKey:@"email"]);
    //NSLog([userDictionary objectForKey:@"position"]);
    //NSLog([userDictionary objectForKey:@"isWriter"]);
    //NSLog([userDictionary objectForKey:@"imageUrl"]);
}


@end
