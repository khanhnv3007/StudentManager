//
//  AdminModel.m
//  StudentManager
//
//  Created by khanhnv3007 on 5/5/14.
//  Copyright (c) 2014 RoxWin. All rights reserved.
//

#import "AdminModel.h"
#import "Admin.h"

@implementation AdminModel

- (id)managedObject{
    Admin *admin = [Admin MR_findFirstByAttribute:@"adminID" withValue:self.adminID];
    if (admin == nil) {
        admin = [Admin MR_createEntity];
    }
    admin.adminID = self.adminID;
    admin.name = self.name;
    admin.birthday = admin.birthday;
    admin.email = self.email;
    admin.phoneNumber = self.phoneNumber;
    admin.address = self.address;
    admin.username = self.username;
    admin.password = self.password;
    admin.avatar = self.avatar;
    
    [admin.managedObjectContext MR_saveOnlySelfAndWait];
    return admin;
}

@end
