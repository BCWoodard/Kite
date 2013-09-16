//
//  KTEUser.h
//  Kite
//
//  Created by Brad Woodard on 9/14/13.
//  Copyright (c) 2013 Brad Woodard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KTEUser : NSObject

@property (strong, nonatomic) NSString  *userID;
@property (strong, nonatomic) NSString  *username;
@property (strong, nonatomic) NSString  *userEmail;

- (instancetype)initWithUserDictionary:(NSDictionary *)userDictionary;


@end
