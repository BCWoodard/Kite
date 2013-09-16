//
//  KTEInitialViewController.h
//  Kite
//
//  Created by Brad Woodard on 9/14/13.
//  Copyright (c) 2013 Brad Woodard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITextfieldScrollViewController.h"
#import "KTEPassLoginDataDelegate.h"

@interface KTEInitialViewController : UITextfieldScrollViewController <KTEPassLoginDataDelegate, UIAlertViewDelegate>

@end
