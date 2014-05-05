//
//  AddTeacherStudentViewController.h
//  StudentManager
//
//  Created by Nguyễn Nam Phong on 5/5/14.
//  Copyright (c) 2014 RoxWin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddTeacherStudentViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *teacherName;
@property (weak, nonatomic) IBOutlet UITextField *teacherUserName;

- (IBAction)addTeacher:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *studentName;
@property (weak, nonatomic) IBOutlet UITextField *studentUsername;

- (IBAction)addStudent:(id)sender;

@end
