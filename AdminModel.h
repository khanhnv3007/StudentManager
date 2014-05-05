//
//  AdminModel.h
//  StudentManager
//
//  Created by khanhnv3007 on 5/5/14.
//  Copyright (c) 2014 RoxWin. All rights reserved.
//

#import "JSONModel.h"

@interface AdminModel : JSONModel
@property (nonatomic, strong) NSString * adminID;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSDate * birthday;
@property (nonatomic, strong) NSString * address;
@property (nonatomic, strong) NSString * avatar;
@property (nonatomic, strong) NSString * email;
@property (nonatomic, strong) NSString * phoneNumber;
@property (nonatomic, strong) NSString * username;
@property (nonatomic, strong) NSString * password;
- (id)managedObject;

@end
