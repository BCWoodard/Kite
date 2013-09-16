//
//  KTECustomCell.h
//  Kite
//
//  Created by Brad Woodard on 9/15/13.
//  Copyright (c) 2013 Brad Woodard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KTECustomCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *appTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel *appDescriptionLabel;
@property (nonatomic, weak) IBOutlet UIImageView *thumbnailImageView;


@end
