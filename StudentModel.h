//
//  StudentModel.h
//  StudentManager
//
//  Created by khanhnv3007 on 5/5/14.
//  Copyright (c) 2014 RoxWin. All rights reserved.
//

#import "JSONModel.h"

@interface StudentModel : JSONModel

@property (nonatomic, strong) NSString * studentID;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSDate * birthday;
@property (nonatomic, strong) NSString * address;
@property (nonatomic, strong) NSString * email;
@property (nonatomic, strong) NSString * phoneNumber;
@property (nonatomic, strong) NSString * username;
@property (nonatomic, strong) NSString * password;
@property (nonatomic, strong) NSString * avatar;
@property (nonatomic, strong) NSSet *studentinClass;
@property (nonatomic, strong) NSManagedObject *markofStudent;

-(id)managedObject;

@end
