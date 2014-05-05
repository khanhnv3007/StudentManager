//
//  Mark.h
//  StudentManager
//
//  Created by khanhnv3007 on 5/5/14.
//  Copyright (c) 2014 RoxWin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Mark : NSManagedObject

@property (nonatomic, retain) NSString * classID;
@property (nonatomic, retain) NSString * studentID;
@property (nonatomic, retain) NSNumber * mid;
@property (nonatomic, retain) NSNumber * average;
@property (nonatomic, retain) NSNumber * final;

@end
