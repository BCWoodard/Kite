//
//  App.h
//  Kite
//
//  Created by Brad Woodard on 9/14/13.
//  Copyright (c) 2013 Brad Woodard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KTEApp : NSObject

@property int                           appID;
@property (strong, nonatomic) NSString  *appName;
@property (strong, nonatomic) NSString  *appAuthor;
@property (strong, nonatomic) NSString  *appDescription;

- (instancetype)initWithAppDictionary:(NSDictionary *)appDictionary;

@end
