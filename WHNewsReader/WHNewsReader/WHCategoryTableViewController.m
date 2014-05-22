//
//  WHCategoryTableViewController.m
//  WHNewsReader
//
//  Created by Leslie Dixon on 5/14/14.
//
//

#import "WHCategoryTableViewController.h"



@interface WHCategoryTableViewController ()
@property NSArray *categories;
@property NSArray *items;
@property NSString *catName;
@property NSString *catId;
@property UIRefreshControl *refreshControl;
@property int typeFlag;//0=init with categories, 1=init with stories

@end

@implementation WHCategoryTableViewController

-(instancetype)initWithCats{
    
    if (self) {
        self.typeFlag=0;
        self.tableView.backgroundColor=[UIColor whiteColor];
        self.tabBarItem.title=@"Search By Category";
        self.tabBarItem.image=[UIImage imageNamed:@"archive-32.png"];
        self.tableView.rowHeight=57;
        self.title = @"Search By Category";
        _categories = [NSArray array];
        [self loadCategories];
    }
    
    
    return self;
}

-(instancetype)initWithStories:(WHCategoryObject *)cat{
    
    if (self) {
        self.catName=cat.name;
        self.catId=cat.categoryId;
        self.typeFlag=1;
        self.tabBarItem.image=[UIImage imageNamed:@"archive-32.png"];
        self.title=[[NSString alloc] initWithFormat:@"%@",self.catName];
        _items = [NSArray array];
        
        [self loadStories];
    }
    
    
    return self;
}

-(void)loadCategories{
    
    //[WHDataRetrieval setUserToken:@"b7a2ac80-67a7-41bb-a7ff-8e6574b0bdf2"];
    [WHDataRetrieval getCategories:[WHDataRetrieval userToken] completetionHandler:
      ^(NSURLResponse *response, NSData *data, NSError *error){
     
         _categories = [NSObject arrayOfType:[WHCategoryObject class] FromJSONData:data];
          NSArray *sortedArray;
          sortedArray = [self.categories sortedArrayUsingComparator:^NSComparisonResult(WHCategoryObject *story1, WHCategoryObject *story2) {
              return [story1.name compare: story2.name];
          }];
          _categories=sortedArray;
         dispatch_async(dispatch_get_main_queue(), ^{
             [self.tableView reloadData];
             [self.refreshControl endRefreshing];
        });
     
     }];
    
    
    
    
}
-(void)loadStories{
    //[WHDataRetrieval setUserToken:@"b7a2ac80-67a7-41bb-a7ff-8e6574b0bdf2"];
    [WHDataRetrieval getStoryByCategory:self.catId userToken:[WHDataRetrieval userToken] completetionHandler:
     ^(NSURLResponse *response, NSData *data, NSError *error){
         
         _items = [NSObject arrayOfType:[WHStoryObject class] FromJSONData:data];
         
         
         dispatch_async(dispatch_get_main_queue(), ^{
             [self.tableView reloadData];
             [self.refreshControl endRefreshing];
         });
         
     }];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.refreshControl = [[UIRefreshControl alloc] initWithFrame:CGRectMake(0, -60, self.tableView.frame.size.width, 60)];
    if(self.typeFlag==0){
        [self.refreshControl addTarget:self action:@selector(loadCategories) forControlEvents:UIControlEventValueChanged];
    }
    else{
        [self.refreshControl addTarget:self action:@selector(loadStories) forControlEvents:UIControlEventValueChanged];
    }
    
    [self.tableView addSubview:self.refreshControl];
    [self.tableView reloadData];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    if(self.typeFlag==0){
        return _categories.count;
    }
    else{
        return _items.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{   WHCategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CategoryTableCell"];
    if(self.typeFlag==0){
    if(!cell){
        cell=[[WHCategoryTableViewCell alloc] init];
        
    }
    WHCategoryObject *cat=[self.categories objectAtIndex:indexPath.row];
        
    cell.itemNameLabel.text=cat.name;
        cell.itemNameLabel.backgroundColor=[UIColor whiteColor];
    cell.catDescription.text=cat.description;
        cell.catDescription.backgroundColor=[UIColor whiteColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundColor=[UIColor whiteColor];
        
    
    
    
    
    return cell;
    }
    else{
        UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, [tableView bounds].size.width, [tableView bounds].size.height)];
            
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
        WHStoryObject *story = [_items objectAtIndex:indexPath.row];
            //cell.textLabel.text = [story title];
            
        UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [tableView bounds].size.width, 20)];
            
        [cell addSubview:customView];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(85,2.5,[tableView bounds].size.width - 100, 45)];
        titleLabel.backgroundColor = [UIColor whiteColor];
        titleLabel.text = story.title;
        titleLabel.numberOfLines = 0;
        UILabel *subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 42.5, [tableView bounds].size.width - 100, 40)];
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
        
        
        titleLabel.font = [UIFont fontWithName:@"Avenir" size:16];
        titleLabel.lineBreakMode=NSLineBreakByWordWrapping;
        
        subTitleLabel.font = [UIFont fontWithName:@"Avenir" size:12];
        subTitleLabel.textColor = [UIColor darkGrayColor];
        subTitleLabel.numberOfLines = 2;
        subTitleLabel.lineBreakMode=NSLineBreakByWordWrapping;
        subTitleLabel.text = story.subtitle;
        
            
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.contentMode=UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds=YES;
            
        imageView.frame = CGRectMake(2.5,2.5,75,75);
        [customView addSubview:titleLabel];
        [customView addSubview:subTitleLabel];
        [customView addSubview:imageView];
        return cell;
    }
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


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.typeFlag==0){
        // Navigation logic may go here, for example:
        // Create the next view controller.
        WHCategoryObject *cat=[self.categories objectAtIndex:indexPath.row];
        WHCategoryTableViewController *detailViewController = [[WHCategoryTableViewController alloc] initWithStories:cat];
    
        // Pass the selected object to the new view controller.
    
        // Push the view controller.
        [self.navigationController pushViewController:detailViewController animated:YES];
        [self.tableView reloadData];
    }
    else{
        WHStoryObject *story = [_items objectAtIndex:[indexPath row]];
        WHStoryViewController *storyVC = [[WHStoryViewController alloc] init];
        storyVC.selectedStory = story;
        
        
        [self.navigationController pushViewController:storyVC animated:YES];
        [self.tableView reloadData];
    }
}


@end
