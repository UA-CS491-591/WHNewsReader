//
//  WHCategoryTableViewController.h
//  WHNewsReader
//
//  Created by Leslie Dixon on 5/14/14.
//
//

#import <UIKit/UIKit.h>
#import "WHCategoryTableViewCell.h"
@interface WHCategoryTableViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
-(instancetype)initWithCats;
-(instancetype)initWithStories:(NSString *)catName;
@end
