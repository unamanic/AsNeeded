//
//  AggregateCell.m
//  AsNeeded
//
//  Created by William Witt on 1/6/14.
//  Copyright (c) 2014 William Witt. All rights reserved.
//

#import "AggregateCell.h"

@implementation AggregateCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
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
