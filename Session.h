//
//  Session.h
//  SetaBase
//
//  Created by Thanh Le on 8/15/12.
//  Copyright (c) 2012 Setacinq. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SESSION_VERSION @"22014"

@interface Session : NSObject

@property (assign, nonatomic) BOOL isFirstTimeLaunching;
@property (nonatomic, strong) NSString* baseUrl;
@property (nonatomic , assign) BOOL isAuthen;
+ (Session *)sharedInstance;

- (void)save;
- (void)getData;
- (void)remove;

////////////////////////////////////////////////////
//Define all Session-related functions here
@end
