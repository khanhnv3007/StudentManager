//
//  Mark.h
//  StudentManager
//
//  Created by khanhnv3007 on 5/7/14.
//  Copyright (c) 2014 RoxWin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Student, Subject;

@interface Mark : NSManagedObject

@property (nonatomic, retain) NSNumber * average;
@property (nonatomic, retain) NSNumber * final;
@property (nonatomic, retain) NSString * markID;
@property (nonatomic, retain) NSNumber * mid;
@property (nonatomic, retain) Student *markOfStudent;
@property (nonatomic, retain) Subject *markOfSubject;

@end
