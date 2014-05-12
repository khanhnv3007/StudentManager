//
//  CreateClass.m
//  StudentManager
//
//  Created by Nguyễn Nam Phong on 5/7/14.
//  Copyright (c) 2014 RoxWin. All rights reserved.
//

#import "CreateClass.h"
#import "Subject.h"
#import "REFrostedViewController.h"
#import "Subject.h"
#import "Teacher.h"
#import "Student.h"
#import "Admin.h"
#import "AppDelegate.h"

@interface CreateClass ()

@property (nonatomic, strong) AppDelegate *appDelegate;
@property (nonatomic, strong) NSArray *teachers;
@property (nonatomic, strong) NSMutableArray *teacherList;
@property (nonatomic, strong) Teacher *teacherIsSelected;
@property (nonatomic, strong) UIPickerView *selectTeacher;

@end

@implementation CreateClass

- (void)createPicker {
	self.selectTeacher = [[UIPickerView alloc] init];
	[self.selectTeacher sizeToFit];
	self.selectTeacher.dataSource = self;
	self.selectTeacher.delegate = self;
	self.selectTeacher.showsSelectionIndicator = YES;
	self.selectTeacher.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
	self.teacher.inputView = self.selectTeacher;
	self.createButton.layer.cornerRadius = 5.0f;
	self.createButton.backgroundColor = [UIColor blueColor];
}

- (void)pickerViewWithDoneButton {
	UIToolbar *keyboardDonebutton = [[UIToolbar alloc] init];
	keyboardDonebutton.barStyle = UIBarStyleBlack;
	keyboardDonebutton.translucent = YES;
	keyboardDonebutton.tintColor = nil;
	[keyboardDonebutton sizeToFit];
	UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(doneClicked:)];
	[keyboardDonebutton setItems:[NSArray arrayWithObjects:doneButton, nil]];
	self.teacher.inputAccessoryView = keyboardDonebutton;
}

- (void)setDateClicked:(id)sender {
	[self.teacher becomeFirstResponder];
}

- (void)doneClicked:(id)sender {
	[self.teacher resignFirstResponder];
}

- (void)init_user {
	self.teachers = [Teacher MR_findAll];
	self.teacherList = [NSMutableArray arrayWithArray:self.teachers];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	[self init_user];
	[self createPicker];
	[self pickerViewWithDoneButton];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

- (IBAction)createClass:(id)sender {
	if (self.name.text == nil && self.teacher.text != nil) {
		[[Util sharedUtil] showMessage:@"Please set class name!" withTitle:@"OOps"];
	}
	else if (self.name.text != nil && self.teacher.text == nil) {
		[[Util sharedUtil] showMessage:@"Please select teacher" withTitle:@"Error!"];
	}
	else if (self.name.text == nil && self.teacher.text == nil) {
		[[Util sharedUtil] showMessage:@"Class and teacher is empty" withTitle:@"Error"];
	}
	else {
		Subject *class = [Subject MR_createEntity];
		class.name = self.name.text;
		class.subjectID = [[Util sharedUtil] generateGUID];
		class.classWithTeacher = self.teacherIsSelected;
		[[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
		[[Util sharedUtil] showMessage:@"Your class has been created!" withTitle:@"Create Success"];
	}
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	if ([pickerView isEqual:self.selectTeacher]) {
		return 1;
	}

	return 0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	if ([pickerView isEqual:self.selectTeacher]) {
		NSLog(@"%d", [self.teacherList count]);
		return [self.teacherList count];
	}
	return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	if ([pickerView isEqual:self.selectTeacher]) {
		Teacher *teacher = self.teacherList[row];
		return [NSString stringWithFormat:@"%@", teacher.name];
	}
	return nil;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[self.view endEditing:YES];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	self.teacherIsSelected = self.teacherList[row];
	self.teacher.text = self.teacherIsSelected.name;
}

@end
