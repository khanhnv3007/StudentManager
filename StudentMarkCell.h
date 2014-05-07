//
//  StudentMarkCell.h
//  StudentManager
//
//  Created by Nguyễn Nam Phong on 5/7/14.
//  Copyright (c) 2014 RoxWin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "Student.h"

@interface StudentMarkCell : SWTableViewCell

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UIImageView *avatar;

@property (weak, nonatomic) IBOutlet UITextField *mid;
@property (weak, nonatomic) IBOutlet UITextField *final;
@property (weak, nonatomic) IBOutlet UITextField *average;

@property (strong, nonatomic) Student *student;

@end
