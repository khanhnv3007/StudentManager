//
//  MarkModel.h
//  StudentManager
//
//  Created by khanhnv3007 on 5/5/14.
//  Copyright (c) 2014 RoxWin. All rights reserved.
//

#import "JSONModel.h"

@interface MarkModel : JSONModel

@property (nonatomic, strong) NSString * classID;
@property (nonatomic, strong) NSString * studentID;
@property (nonatomic, strong) NSNumber * mid;
@property (nonatomic, strong) NSNumber * average;
@property (nonatomic, strong) NSNumber * final;
@property (nonatomic, strong) NSString * markID;

- (id)managedObject;

@end
