//
//  KTEUser.m
//  Kite
//
//  Created by Brad Woodard on 9/14/13.
//  Copyright (c) 2013 Brad Woodard. All rights reserved.
//

#import "KTEUser.h"

@implementation KTEUser


- (instancetype)initWithUserDictionary:(NSDictionary *)userDictionary
{
    self = [super init];
    
    if (self) {
        _userID = [userDictionary valueForKey:@"id"];
        _username = [userDictionary valueForKey:@"name"];
        _userEmail = [userDictionary valueForKey:@"email"];
    }
    
    return self;
    
}


@end
