//
//  UpdateMark.h
//  StudentManager
//
//  Created by Nguyễn Nam Phong on 5/12/14.
//  Copyright (c) 2014 RoxWin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Mark.h"
#import "Student.h"
@interface UpdateMark : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *mid;
@property (weak, nonatomic) IBOutlet UITextField *final;
@property (weak, nonatomic) IBOutlet UITextField *average;

@property (nonatomic, strong) Mark *mark;
@property (nonatomic, strong) Student *student;

- (IBAction)updateMark:(id)sender;

@end
