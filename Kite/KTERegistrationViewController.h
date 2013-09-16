//
//  KTEViewController.h
//  Kite
//
//  Created by Brad Woodard on 9/14/13.
//  Copyright (c) 2013 Brad Woodard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITextfieldScrollViewController.h"
#import "KTEPassLoginDataDelegate.h"

@interface KTERegistrationViewController : UITextfieldScrollViewController <UITextFieldDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) NSArray   *incomingAppsArray;
@property (strong, nonatomic) id<KTEPassLoginDataDelegate>delegate;

@end
