//
//  KTEScreen.m
//  Kite
//
//  Created by Brad Woodard on 9/14/13.
//  Copyright (c) 2013 Brad Woodard. All rights reserved.
//

#import "KTEScreen.h"

@implementation KTEScreen


- (instancetype)initWithScreenDictionary:(NSDictionary *)screenDictionary
{
    self = [super init];
    
    if (self) {
        _screenID = [[screenDictionary valueForKey:@"id"] intValue];
        _screenName = [screenDictionary valueForKey:@"name"];
        _screenURL = [screenDictionary valueForKey:@"image_url"];
    }
    
    return self;
}

@end
