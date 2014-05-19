//
//  WHCategoryTableViewController.h
//  WHNewsReader
//
//  Created by Leslie Dixon on 5/14/14.
//
//

#import <UIKit/UIKit.h>
#import "WHCategoryTableViewCell.h"
#import "WHDataRetrieval.h"
#import "WHCategoryObject.h"
#import "WHStoryObject.h"
@interface WHCategoryTableViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate>
-(instancetype)initWithCats;
-(instancetype)initWithStories:(NSString *)catName;
@end
