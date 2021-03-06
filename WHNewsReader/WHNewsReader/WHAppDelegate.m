//
//  WHAppDelegate.m
//  WHNewsReader
//
//  Created by Mason Saucier on 5/12/14.
//
//

#import "WHAppDelegate.h"
#import "NSObject+ObjectMap.h"
#import "WHStoryObject.h"
#import "WHSearchTableViewController.h"
#import "WHCategoryTableViewController.h"
#import "WHRecentTableViewController.h"
#import "WHLoginViewController.h"


@implementation WHAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
//    _tabBarController = [[UITabBarController alloc] init];
    
    WHLoginViewController *loginController = [[WHLoginViewController alloc] init];
    //loginController.title = @"Login";
    //UINavigationController *loginNavController = [[UINavigationController alloc] initWithRootViewController:loginController];
    loginController.window = self.window;
    [self.window setRootViewController:loginController];

//    WHSearchTableViewController *searchController = [[WHSearchTableViewController alloc] init];
//    searchController.title = @"Search Stories";
//    UINavigationController *searchNavController = [[UINavigationController alloc] initWithRootViewController:searchController];
//        
//        
//    WHRecentTableViewController *recentController = [[WHRecentTableViewController alloc] init];
//    recentController.title = @"Recent Stories";
//    recentController.tabBarItem.image = [UIImage imageNamed:@"recent-25.png"];
//    UINavigationController *recentNavController = [[UINavigationController alloc] initWithRootViewController:recentController];
//        
//    WHCategoryTableViewController *categoryController =[[WHCategoryTableViewController alloc] initWithCats];
//    categoryController.title=@"Search By Category";
//    UINavigationController *catNavController = [[UINavigationController alloc] initWithRootViewController:categoryController];
//        
//    [_tabBarController setViewControllers:@[recentNavController, searchNavController, catNavController]];
//        
//    //[loginNavController pushViewController:_tabBarController animated:YES];
//        
//    //[self.window setRootViewController:_tabBarController];
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
