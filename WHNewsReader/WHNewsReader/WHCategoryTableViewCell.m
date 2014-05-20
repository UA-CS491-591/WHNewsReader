//
//  WHCategoryTableViewCell.m
//  WHNewsReader
//
//  Created by Student on 5/15/14.
//  Copyright (c) 2014 Washington Herald. All rights reserved.
//

#import "WHCategoryTableViewCell.h"

@implementation WHCategoryTableViewCell

-(instancetype)init{
    self=[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([WHCategoryTableViewCell class]) owner:nil options:nil][0];
    self.backgroundColor= [UIColor whiteColor];
    return self;
}


- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
