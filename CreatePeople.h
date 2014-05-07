//
//  CreatePeople.h
//  StudentManager
//
//  Created by Nguyễn Nam Phong on 5/7/14.
//  Copyright (c) 2014 RoxWin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreatePeople : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *username;

@property (weak, nonatomic) IBOutlet UISegmentedControl *selectUser;

- (IBAction)createPeople:(id)sender;
- (IBAction)showMenu:(id)sender;

@property (nonatomic, strong) UIPickerView *selectTeacher;

@end
