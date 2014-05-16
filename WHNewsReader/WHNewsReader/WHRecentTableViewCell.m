//
//  WHRecentTableViewCell.m
//  WHNewsReader
//
//  Created by Ryan Hill on 5/14/14.
//
//

#import "WHRecentTableViewCell.h"

@implementation WHRecentTableViewCell

-(id)init
{
    self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([WHRecentTableViewCell class]) owner:nil options:nil][0];
    if(self)
    {
        
    }
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
