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
@property NSArray *items;
@property UIRefreshControl *refreshControl;
@end

@implementation WHRecentTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self populateInitialData];
    
    _refreshControl = [[UIRefreshControl alloc] initWithFrame:CGRectMake(0, -60, _recentStoriesTableView.frame.size.width, 60)];
    
    [_refreshControl addTarget:self action:@selector(populateInitialData) forControlEvents:UIControlEventValueChanged];
    
    
    
    [_recentStoriesTableView addSubview:_refreshControl];
    
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
    
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [tableView bounds].size.width, 20)];
    
    [cell addSubview:customView];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(85,1.5,[tableView bounds].size.width - 110, 45)];
    titleLabel.backgroundColor = [UIColor whiteColor];
    titleLabel.lineBreakMode=NSLineBreakByWordWrapping;
    titleLabel.numberOfLines=2;
    titleLabel.text = story.title;
    
    UILabel *subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 41.5, [tableView bounds].size.width - 110, 40)];
    subTitleLabel.backgroundColor = [UIColor whiteColor];
    
    UIImage *image;
    
    if(story.imageUrl == nil)
    {
        image = [UIImage imageNamed:@"Icononly copy120.png"];
    }
    else
    {
        image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:story.imageUrl]]];
    }
    
    titleLabel.font = [UIFont fontWithName:@"Avenir" size:16];
    subTitleLabel.font = [UIFont fontWithName:@"Avenir" size:12];
    subTitleLabel.textColor = [UIColor darkGrayColor];
    subTitleLabel.numberOfLines = 2;
    subTitleLabel.lineBreakMode=NSLineBreakByWordWrapping;
    subTitleLabel.text = story.subtitle;
    titleLabel.text = story.title;
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    
    
    imageView.frame = CGRectMake(0,0,80,80);
    [customView addSubview:titleLabel];
    [customView addSubview:subTitleLabel];
    [customView addSubview:imageView];
    return cell;
}

-(void)populateInitialData
{
    
    [WHDataRetrieval getStoryRecent:[WHDataRetrieval userToken] completetionHandler:
     ^(NSURLResponse *response, NSData *data, NSError *error){
         
         _items = [NSObject arrayOfType:[WHStoryObject class] FromJSONData:data];
         
         dispatch_async(dispatch_get_main_queue(), ^{
             [self.recentStoriesTableView reloadData];
             [_refreshControl endRefreshing];
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
