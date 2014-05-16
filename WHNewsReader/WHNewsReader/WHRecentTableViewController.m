//
//  WHRecentTableViewController.m
//  WHNewsReader
//
//  Created by Ryan Hill on 5/14/14.
//
//

#import "WHRecentTableViewController.h"
#import "WHRecentObject.h"
#import "WHRecentTableViewCell.h"
#import "WHDataRetrieval.h"
#import "WHStoryObject.h"
#import "WHStoryViewController.h"

@interface WHRecentTableViewController ()

@property (weak, nonatomic) IBOutlet UITableView *recentStoriesTableView;
@property NSMutableArray *recentItems;
@property NSArray *items;
@end

@implementation WHRecentTableViewController

-(void)loadTestData
{
    WHRecentObject *item1 = [[WHRecentObject alloc] init];
    item1.name = @"Story 1";
    [_recentItems addObject:item1];
    WHRecentObject *item2 = [[WHRecentObject alloc] init];
    item2.name = @"Story 2";
    [_recentItems addObject:item2];
    WHRecentObject *item3 = [[WHRecentObject alloc] init];
    item3.name = @"Story 3";
    [_recentItems addObject:item3];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _recentItems = [[NSMutableArray alloc] init];
    //[self loadTestData];
    [self populateInitialData];
    
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
    //return [self.recentItems count];
    return [self.items count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //static NSString *CellIdentifier = @"WHRecentTableViewCell";
    WHRecentTableViewCell *cell = [[WHRecentTableViewCell alloc] init];
    if(!cell)
    {
       
    }
    
    // Configure the cell...
    //WHRecentObject *item = [self.recentItems objectAtIndex:indexPath.row];
    WHStoryObject *item = [self.items objectAtIndex:indexPath.row];
    cell.itemNameLabel.text = [item title];
    return cell;
}

-(void)populateInitialData
{
    [WHDataRetrieval setUserToken:@"b7a2ac80-67a7-41bb-a7ff-8e6574b0bdf2"];
    [WHDataRetrieval getStoryRecent:[WHDataRetrieval userToken] completetionHandler:
     ^(NSURLResponse *response, NSData *data, NSError *error){
         
         _items = [NSObject arrayOfType:[WHStoryObject class] FromJSONData:data];
         NSLog(@"%@",_items);
         
         dispatch_async(dispatch_get_main_queue(), ^{
             //[self.tableView reloadData];
             [self.recentStoriesTableView reloadData];
             
         });
         
     }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WHStoryObject *story = [_items objectAtIndex:[indexPath row]];
    WHStoryViewController *storyVC = [[WHStoryViewController alloc] init];
    storyVC.selectedStory = story;
    
    [self.navigationController pushViewController:storyVC animated:YES];
    
}


@end
