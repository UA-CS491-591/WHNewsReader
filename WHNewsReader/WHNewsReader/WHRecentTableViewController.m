//
//  WHRecentTableViewController.m
//  WHNewsReader
//
//  Created by Ryan Hill on 5/14/14.
//
//

#import "WHRecentTableViewController.h"
#import "WHRecentObject.h"
#import "WHDataRetrieval.h"
#import "WHStoryObject.h"
#import "WHStoryViewController.h"

@interface WHRecentTableViewController ()

@property (weak, nonatomic) IBOutlet UITableView *recentStoriesTableView;
@property NSMutableArray *recentItems;
@property NSArray *items;
@end

@implementation WHRecentTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    _recentItems = [[NSMutableArray alloc] init];
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
    return [self.items count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, [tableView bounds].size.width, [tableView bounds].size.height)];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    WHStoryObject *story = [_items objectAtIndex:indexPath.row];
    //cell.textLabel.text = [story title];
    
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [tableView bounds].size.width, 20)];
    
    [cell addSubview:customView];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(42,2,[tableView bounds].size.width - 70, 30)];
    titleLabel.text = story.title;
    UILabel *subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(52, 22, [tableView bounds].size.width - 80, 20)];
    
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:story.imageUrl]]];
    
    titleLabel.font = [titleLabel.font fontWithSize:20];
    subTitleLabel.font = [subTitleLabel.font fontWithSize:12];
    
    subTitleLabel.text = story.subtitle;
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    imageView.frame = CGRectMake(2,2,40,40);
    
    [customView addSubview:titleLabel];
    [customView addSubview:subTitleLabel];
    [customView addSubview:imageView];
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
