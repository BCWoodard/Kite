//
//  KTEPassLoginDataDelegate.h
//  Kite
//
//  Created by Brad Woodard on 9/15/13.
//  Copyright (c) 2013 Brad Woodard. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KTEPassLoginDataDelegate <NSObject>

- (void)passBackLoginEmail:(NSString *)loginEmail andLoginPassword:(NSString *)loginPassword;
@end
