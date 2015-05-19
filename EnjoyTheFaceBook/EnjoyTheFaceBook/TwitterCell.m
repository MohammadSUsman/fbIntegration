//
//  TwitterCell.m
//  EnjoyTheFaceBook
//
//  Created by SulamanShami on 1/23/14.
//  Copyright (c) 2014 SulamanShami. All rights reserved.
//

#import "TwitterCell.h"

@implementation TwitterCell

{
    UITableViewCell *cell;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
