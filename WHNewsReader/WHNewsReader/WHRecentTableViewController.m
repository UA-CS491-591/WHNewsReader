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

@interface WHRecentTableViewController ()

@property (weak, nonatomic) IBOutlet UITableView *recentStoriesTableView;
@property NSMutableArray *recentItems;

@end

@implementation WHRecentTableViewController

-(void)loadTestData
{
    WHRecentObject *item1 = [[WHRecentObject alloc] init];
    item1.name = @"Story 1";
    [self.recentItems addObject:item1];
    WHRecentObject *item2 = [[WHRecentObject alloc] init];
    item2.name = @"Story 2";
    [self.recentItems addObject:item2];
    WHRecentObject *item3 = [[WHRecentObject alloc] init];
    item3.name = @"Story 3";
    [self.recentItems addObject:item3];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.recentItems = [[NSMutableArray alloc] init];
    [self loadTestData];
    //[self sendAsynchronousRequest];
    
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

#pragma mark - Story list connection

-(void)sendAsynchronousRequest{
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
    
    //Create url
    NSString *userToken = @"b7a2ac80-67a7-41bb-a7ff-8e6574b0bdf2";
    NSString *stringURL = [NSString stringWithFormat:@"https://mobileweb.caps.ua.edu/cs491/api/Story/recent?token=%@",userToken];
    NSURL *url = [NSURL URLWithString:stringURL];
    
    //Create request object
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:5.0];
    
    //Make request
    [NSURLConnection sendAsynchronousRequest:request queue:operationQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        //3. Handle response
        NSString *responseString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        
        //Hop back to main thread to update UI
        dispatch_async(dispatch_get_main_queue(), ^{
            //_responseTextView.text = responseString;
            NSLog(@"%@",responseString);
        });
        
    }];
}








@end
