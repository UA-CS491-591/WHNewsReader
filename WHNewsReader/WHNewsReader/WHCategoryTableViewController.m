//
//  WHCategoryTableViewController.m
//  WHNewsReader
//
//  Created by Leslie Dixon on 5/14/14.
//
//

#import "WHCategoryTableViewController.h"
#import "WHRecentTableViewCell.h"


@interface WHCategoryTableViewController ()
@property NSMutableArray *categories;
-(NSMutableArray *)checkArray;
-(void)loadCategories;
@end

@implementation WHCategoryTableViewController

-(instancetype)initWithCats{
    
    if (self) {
        
        self.tabBarItem.title=@"Search By Category";
        self.tabBarItem.image=[UIImage imageNamed:@"archive-32.png"];
        
        self.title = @"Search By Category";
        _categories = [NSMutableArray array];
        [self loadCategories];
    }
    
    
    return self;
}

-(instancetype)initWithStories:(NSString *)catName{
    if (self) {
        
        self.tabBarItem.image=[UIImage imageNamed:@"archive-32.png"];
        self.title=[[NSString alloc] initWithFormat:@"Stories in %@ Category",catName];
        _categories = [NSMutableArray array];
        [self loadStories];
    }
    
    
    return self;
}

-(NSMutableArray *)checkArray{
    if(self.categories.count==0){
        [self loadCategories];
    }
    return self.categories;
}

-(void)loadCategories{
    [_categories addObject:@"Test1"];
    [_categories addObject:@"Test2"];
    [_categories addObject:@"Testing the bounds"];
}
-(void)loadStories{
    [_categories addObject:@"Story1"];
    [_categories addObject:@"Story2"];
    [_categories addObject:@"Testing the bounds"];
    
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
    return _categories.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CategoryTableCell"];
    
    if(!cell){
        cell=[[UITableViewCell alloc] init];
        
    }
    cell.textLabel.text=_categories[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    
    return cell;
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
    // Navigation logic may go here, for example:
    // Create the next view controller.
    UITableViewCell *workingCell = [tableView cellForRowAtIndexPath:indexPath];
    WHCategoryTableViewController *detailViewController = [[WHCategoryTableViewController alloc] initWithStories:workingCell.textLabel.text];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}


@end
