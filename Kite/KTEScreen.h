//
//  KTEScreen.h
//  Kite
//
//  Created by Brad Woodard on 9/14/13.
//  Copyright (c) 2013 Brad Woodard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KTEScreen : NSObject

@property int                           screenID;
@property (strong, nonatomic) NSString  *screenName;
@property (strong, nonatomic) NSString  *screenURL;


- (instancetype)initWithScreenDictionary:(NSDictionary *)screenDictionary;

@end
