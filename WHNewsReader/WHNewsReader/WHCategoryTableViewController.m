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
@property int typeFlag;//0=init with categories, 1=init with stories

-(void)loadCategories;
@end

@implementation WHCategoryTableViewController

-(instancetype)initWithCats{
    
    if (self) {
        self.typeFlag=0;
        
        self.tabBarItem.title=@"Search By Category";
        self.tabBarItem.image=[UIImage imageNamed:@"archive-32.png"];
        
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
        self.title=[[NSString alloc] initWithFormat:@"Stories in %@ Category",self.catName];
        _items = [NSArray array];
        [self loadStories];
    }
    
    
    return self;
}

-(void)loadCategories{
    
    [WHDataRetrieval setUserToken:@"b7a2ac80-67a7-41bb-a7ff-8e6574b0bdf2"];
    [WHDataRetrieval getCategories:[WHDataRetrieval userToken] completetionHandler:
      ^(NSURLResponse *response, NSData *data, NSError *error){
     
         _categories = [NSObject arrayOfType:[WHCategoryObject class] FromJSONData:data];
     
         dispatch_async(dispatch_get_main_queue(), ^{
         [self.tableView reloadData];
        });
     
     }];
    
    
    
    
}
-(void)loadStories{
    [WHDataRetrieval setUserToken:@"b7a2ac80-67a7-41bb-a7ff-8e6574b0bdf2"];
    [WHDataRetrieval getStoryByCategory:self.catId userToken:[WHDataRetrieval userToken] completetionHandler:
     ^(NSURLResponse *response, NSData *data, NSError *error){
         
         _items = [NSObject arrayOfType:[WHStoryObject class] FromJSONData:data];
         
         dispatch_async(dispatch_get_main_queue(), ^{
             [self.tableView reloadData];
         });
         
     }];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
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
{   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CategoryTableCell"];
    if(self.typeFlag==0){
    if(!cell){
        cell=[[UITableViewCell alloc] init];
        
    }
    WHCategoryObject *cat=[self.categories objectAtIndex:indexPath.row];
        
    cell.textLabel.text=cat.name;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    
    return cell;
    }
    else{
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
    }
    else{
        WHStoryObject *story = [_items objectAtIndex:[indexPath row]];
        WHStoryViewController *storyVC = [[WHStoryViewController alloc] init];
        storyVC.selectedStory = story;
        
        [self.navigationController pushViewController:storyVC animated:YES];
    }
}


@end
