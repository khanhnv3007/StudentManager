//
//  Admin.h
//  StudentManager
//
//  Created by khanhnv3007 on 5/7/14.
//  Copyright (c) 2014 RoxWin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Admin : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * adminID;
@property (nonatomic, retain) NSString * avatar;
@property (nonatomic, retain) NSDate * birthday;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * phoneNumber;
@property (nonatomic, retain) NSString * username;

@end
