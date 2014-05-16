//
//  WHRecentTableViewController.m
//  WHNewsReader
//
//  Created by Student on 5/14/14.
//
//

#import "WHRecentTableViewController.h"
#import "WHRecentObject.h"
#import "WHRecentTableViewCell.h"
#import "WHDataRetrieval.h"

@interface WHRecentTableViewController ()

@property (weak, nonatomic) IBOutlet UITableView *recentStoriesTableView;
@property NSMutableArray *recentItems;

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
    [self makeRequest];
    
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
    return [self.recentItems count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //static NSString *CellIdentifier = @"WHRecentTableViewCell";
    WHRecentTableViewCell *cell = [[WHRecentTableViewCell alloc] init];
    if(!cell)
    {
       
    }
    
    // Configure the cell...
    WHRecentObject *item = [self.recentItems objectAtIndex:indexPath.row];
    cell.itemNameLabel.text = item.name;
    return cell;
}

-(void)makeRequest
{
    NSString *userToken = @"b7a2ac80-67a7-41bb-a7ff-8e6574b0bdf2";;
    
    [WHDataRetrieval getStoryRecent:userToken completetionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        NSString *responseString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        //NSLog(@"%@",responseString);
        
        NSArray *array = [responseString componentsSeparatedByString:@","];
        //NSLog(@"%@",test);
        
        for(NSString *title in array)
        {
            if([title rangeOfString:@"\"title\":"].location != NSNotFound)
            {
                WHRecentObject *item = [[WHRecentObject alloc] init];
                item.name = title;
                [_recentItems addObject:item];
                //NSLog(@"%@",title);
                NSLog(@"%@",self.recentItems);
                
            }
        }
        
    }];
    //NSLog(@"%@",self.recentItems);
}






@end
