//
//  Session.m
//  SetaBase
//
//  Created by Thanh Le on 8/15/12.
//  Copyright (c) 2012 Setacinq. All rights reserved.
//

#import "Session.h"
#import "NSObject+Extension.h"

#define SESSION_KEY @"SESSION_DATA"

@implementation Session

+ (Session*)sharedInstance {
    DEFINE_SHARED_INSTANCE_USING_BLOCK(^{
        return [[self alloc] init];
    });
}

- (id)init {
    if (self = [super init]) {
        //Init
        [self getData];
    }
    
    return self;
}

- (void)initData {
    self.isFirstTimeLaunching = YES;
    self.isAuthen = NO;
}

/*
 * Save properties to NSUserDefaults
 */
- (void)save {
	NSDictionary *allDataTmp = [self propertiesDictionary];
    NSMutableDictionary *allData = [[NSMutableDictionary alloc] initWithDictionary:allDataTmp];
	
	for (id key in [allDataTmp allKeys]) {
		id value = [allDataTmp objectForKey:key];
		
		if (!([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSDictionary class]])) {
			[allData removeObjectForKey:key];
			//			DLog(@"Remove key: %@", key);
		}
	}
	
	DLog(@"Save Session: %@", allData);
	
	//Save session
	NSString *sessionKey = [NSString stringWithFormat:@"%@_%@", SESSION_KEY, SESSION_VERSION];
	
    [[NSUserDefaults standardUserDefaults] setObject:allData forKey:sessionKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/*
 * Get all properties from NSUserDefaults
 */
- (void)getData {
	NSString *sessionKey = [NSString stringWithFormat:@"%@_%@", SESSION_KEY, SESSION_VERSION];
	
    NSDictionary *allData = [[NSUserDefaults standardUserDefaults] objectForKey:sessionKey];
    DLog(@"Session's saved data: %@", allData);
	
    if (allData && ![allData isEqual:[NSNull null]]) {
//		[self initData];
		
        NSArray *keyArray =  [allData allKeys];
        int count = [keyArray count];
        for (int i=0; i < count; i++) {
            id obj = [allData objectForKey:[keyArray objectAtIndex:i]];
			if ([self respondsToSelector:NSSelectorFromString([keyArray objectAtIndex:i])]) {
				DLog(@"SetValue for key: %@",[keyArray objectAtIndex:i]);
				[self setValue:obj forKey:[keyArray objectAtIndex:i]];
			}
        }
    } else {
        //Init some value
        [self initData];
    }
}

- (void)remove
{
    NSString *sessionKey = [NSString stringWithFormat:@"%@_%@", SESSION_KEY, SESSION_VERSION];
    // Remove data
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:sessionKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
