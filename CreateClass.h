//
//  CreateClass.h
//  StudentManager
//
//  Created by Nguyễn Nam Phong on 5/7/14.
//  Copyright (c) 2014 RoxWin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateClass : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *name;

- (IBAction)createClass:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *teacher;

@property (weak, nonatomic) IBOutlet UIButton *createButton;


@end
