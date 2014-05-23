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
#import "WHAppDelegate.h"
#import "WHSearchTableView.h"

@interface WHSearchTableViewController ()

@property NSMutableArray *items;
@property UISearchDisplayController *searchController;
@property UISearchBar *searchBar;
@property UITextField *textfield;

@end

@implementation WHSearchTableViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //_searchTableView = [[WHSearchTableView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        //self.tabBarItem.title = @"Search";
        self.tabBarItem.image = [UIImage imageNamed:@"search-25.png"];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    // disable serch bar when loading
    //[tableSearchBar setUserInteractionEnabled:NO];
    
    self.tableView.separatorInset = UIEdgeInsetsZero;
    
    /*  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(didTapMyButton:)];
     */
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
    
    UISearchDisplayController *searchDC = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    [searchBar sizeToFit];
    searchBar.delegate = self;
    searchBar.placeholder = @"Search";
    self.tableView.tableHeaderView = searchBar;
    _searchBar = searchBar;
    
    searchDC.delegate = self;
    searchDC.searchResultsDataSource = self;
    searchDC.searchResultsDelegate = self;
    [searchDC.searchBar setShowsCancelButton:YES];
    
    for (UIView* subView in self.searchBar.subviews) {
        for (UIView* searchView in subView.subviews) {
            if ([searchView isKindOfClass:[UITextField class]]) {
                _textfield = (UITextField*)searchView;
                break;
            }
        }
    }
    [searchBar becomeFirstResponder];
    [_textfield becomeFirstResponder];
    
    
    //[self populateInitialData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [_textfield becomeFirstResponder];
}

/*
 -(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
 [searchBar resignFirstResponder];
 searchBar.text = @"";
 }*/

-(void)populateInitialData
{
    //[WHDataRetrieval setUserToken:@"b7a2ac80-67a7-41bb-a7ff-8e6574b0bdf2"];
    [WHDataRetrieval getStoryRecent:[WHDataRetrieval userToken] completetionHandler:
     ^(NSURLResponse *response, NSData *data, NSError *error){
         
         _items =[[NSMutableArray alloc] initWithArray:[NSObject arrayOfType:[WHStoryObject class] FromJSONData:data]];
         
         dispatch_async(dispatch_get_main_queue(), ^{
             [self.tableView reloadData];
         });
     }];
}

-(void)refreshTable
{
    if ([self.searchBar.text  isEqual: @""]) {
        //[self populateInitialData];
        _items = [[NSMutableArray alloc] init];
        [self.tableView reloadData];
    }
    else {
        //[WHDataRetrieval setUserToken:@"b7a2ac80-67a7-41bb-a7ff-8e6574b0bdf2"];
        [WHDataRetrieval getStorySearch:[WHDataRetrieval userToken] searchString:self.searchBar.text completetionHandler:
         ^(NSURLResponse *response, NSData *data, NSError *error){
             
             _items =[[NSMutableArray alloc] initWithArray:[NSObject arrayOfType:[WHStoryObject class] FromJSONData:data]];
             
             dispatch_async(dispatch_get_main_queue(), ^{
                 [self.tableView reloadData];
             });
             
         }];
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self refreshTable];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 80;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    //[self populateInitialData];
    [searchBar resignFirstResponder];
    _searchBar.text = @"";
    [self refreshTable];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, [tableView bounds].size.width, [tableView bounds].size.height)];
    
    
    
    
    @try {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        WHStoryObject *story = [_items objectAtIndex:indexPath.row];
        //cell.textLabel.text = [story title];
        
        
        UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [tableView bounds].size.width, 20)];
        
        [cell addSubview:customView];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(85,2.5,[tableView bounds].size.width - 100, 40)];
        titleLabel.backgroundColor = [UIColor whiteColor];
        titleLabel.text = story.title;
        UILabel *subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 32.5, [tableView bounds].size.width - 100, 40)];
        subTitleLabel.backgroundColor = [UIColor whiteColor];
        
        //        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:story.imageUrl]]];
        
        UIImage *image;
        
        if(story.imageUrl == nil)
        {
            image = [UIImage imageNamed:@"Icononly copy120.png"];
        }
        else
        {
            image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:story.imageUrl]]];
        }
        
        titleLabel.font = [UIFont fontWithName:@"Avenir" size:18];
        subTitleLabel.font = [UIFont fontWithName:@"Avenir" size:12];
        subTitleLabel.textColor = [UIColor darkGrayColor];
        subTitleLabel.numberOfLines = 2;
        subTitleLabel.text = story.subtitle;
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.frame = CGRectMake(0,0,80,80);
        
        [customView addSubview:titleLabel];
        [customView addSubview:subTitleLabel];
        [customView addSubview:imageView];
        return cell;
    }
    @catch (NSException * e) {
        return cell;
    }
    
    
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    /*[WHDataRetrieval setUserToken:@"b7a2ac80-67a7-41bb-a7ff-8e6574b0bdf2"];
     [WHDataRetrieval getStorySearch:[WHDataRetrieval userToken] searchString:searchBar.text completetionHandler:
     ^(NSURLResponse *response, NSData *data, NSError *error){
     
     _items = [NSObject arrayOfType:[WHStoryObject class] FromJSONData:data];
     
     dispatch_async(dispatch_get_main_queue(), ^{
     [self.tableView reloadData];
     });
     
     }];
     
     [searchBar resignFirstResponder];*/
    
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    /*[WHDataRetrieval setUserToken:@"b7a2ac80-67a7-41bb-a7ff-8e6574b0bdf2"];
     [WHDataRetrieval getStorySearch:[WHDataRetrieval userToken] searchString:searchBar.text completetionHandler:
     ^(NSURLResponse *response, NSData *data, NSError *error){
     
     _items = [NSObject arrayOfType:[WHStoryObject class] FromJSONData:data];
     
     dispatch_async(dispatch_get_main_queue(), ^{
     [self.tableView reloadData];
     });
     
     }];
     
     [searchBar resignFirstResponder];*/
}

- (void)handleSearch:(UISearchBar *)searchBar
{
    /* [WHDataRetrieval setUserToken:@"b7a2ac80-67a7-41bb-a7ff-8e6574b0bdf2"];
     [WHDataRetrieval getStorySearch:[WHDataRetrieval userToken] searchString:searchBar.text completetionHandler:
     ^(NSURLResponse *response, NSData *data, NSError *error){
     
     _items = [NSObject arrayOfType:[WHStoryObject class] FromJSONData:data];
     
     dispatch_async(dispatch_get_main_queue(), ^{
     [self.tableView reloadData];
     });
     
     }];*/
    
    [searchBar resignFirstResponder];
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
    //[tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    WHStoryObject *story = [_items objectAtIndex:[indexPath row]];
    WHStoryViewController *storyVC = [[WHStoryViewController alloc] init];
    storyVC.selectedStory = story;
    
    [self.navigationController pushViewController:storyVC animated:YES];
    
}

@end
