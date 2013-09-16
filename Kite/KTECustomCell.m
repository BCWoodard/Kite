//
//  KTECustomCell.m
//  Kite
//
//  Created by Brad Woodard on 9/15/13.
//  Copyright (c) 2013 Brad Woodard. All rights reserved.
//

#import "KTECustomCell.h"

@implementation KTECustomCell
@synthesize appTitleLabel, appDescriptionLabel, thumbnailImageView;

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
