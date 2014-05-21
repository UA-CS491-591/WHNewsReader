//
//  WHCategoryTableViewCell.h
//  WHNewsReader
//
//  Created by Student on 5/15/14.
//  Copyright (c) 2014 Washington Herald. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WHCategoryObject.h"
@interface WHCategoryTableViewCell : UITableViewCell


@property WHCategoryObject *associatedCategory;
@property (weak, nonatomic) IBOutlet UILabel *itemNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *catDescription;

@end
