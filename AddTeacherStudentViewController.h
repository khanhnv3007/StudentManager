//
//  AddTeacherStudentViewController.h
//  StudentManager
//
//  Created by Nguyễn Nam Phong on 5/5/14.
//  Copyright (c) 2014 RoxWin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseloginController.h"

@interface AddTeacherStudentViewController : BaseloginController

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *username;

@property (weak, nonatomic) IBOutlet UISegmentedControl *selectAuthor;


- (IBAction)addToTheList:(id)sender;

@end
