//
//  App.m
//  Kite
//
//  Created by Brad Woodard on 9/14/13.
//  Copyright (c) 2013 Brad Woodard. All rights reserved.
//

#import "KTEApp.h"

@implementation KTEApp

- (instancetype)initWithAppDictionary:(NSDictionary *)appDictionary
{
    self = [super init];
    
    if (self) {
        _appID = [[appDictionary valueForKey:@"id"] intValue];
        _appName = [appDictionary valueForKey:@"name"];
        _appAuthor = [appDictionary valueForKey:@"author"];
        _appDescription = [appDictionary valueForKey:@"description"];
    }
    
    return self;

}

@end
