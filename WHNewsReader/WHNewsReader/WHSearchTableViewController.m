//
//  WHSearchTableViewController.m
//  WHNewsReader
//
//  Created by Mason Saucier on 5/13/14.
//
//

#import "WHSearchTableViewController.h"
#import "WHDataRetrieval.h"
#import "NSObject+ObjectMap.h"
#import "WHStoryObject.h"
#import "WHStoryViewController.h"

@interface WHSearchTableViewController ()

@property NSArray *items;

@end

@implementation WHSearchTableViewController


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        //_searchTableView = [[WHSearchTableView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.tabBarItem.title = @"Search";
        self.tabBarItem.image = [UIImage imageNamed:@"search-25.png"];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // setup searchBar and searchDisplayController
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
    [searchBar sizeToFit];
    searchBar.delegate = self;
    searchBar.placeholder = @"Search";
    self.tableView.tableHeaderView = searchBar;
    
    UISearchDisplayController *searchDC = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    
    // The above assigns self.searchDisplayController, but without retaining.
    // Force the read-only property to be set and retained.
    [self performSelector:@selector(setSearchDisplayController:) withObject:searchDC];
    
    searchDC.delegate = self;
    searchDC.searchResultsDataSource = self;
    searchDC.searchResultsDelegate = self;
    
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return _items.count > 0 ? 1 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, [tableView bounds].size.width, [tableView bounds].size.height)];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    //int temp = [indexPath row];
    
    WHStoryObject *story = [_items objectAtIndex:indexPath.row];
    cell.textLabel.text = [story title];
    
    return cell;
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [WHDataRetrieval setUserToken:@"b7a2ac80-67a7-41bb-a7ff-8e6574b0bdf2"];
    [WHDataRetrieval getStorySearch:[WHDataRetrieval userToken] searchString:searchBar.text completetionHandler:
     ^(NSURLResponse *response, NSData *data, NSError *error){
         
         _items = [NSObject arrayOfType:[WHStoryObject class] FromJSONData:data];
         
         dispatch_async(dispatch_get_main_queue(), ^{
             [self.tableView reloadData];
         });
         
     }];
    
    [searchBar resignFirstResponder];

}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{}

- (void)handleSearch:(UISearchBar *)searchBar
{
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    WHStoryObject *story = [_items objectAtIndex:[indexPath row]];
    WHStoryViewController *storyVC = [[WHStoryViewController alloc] init];
    storyVC.selectedStory = story;
    
    [self.navigationController pushViewController:storyVC animated:YES];
    
}

@end
