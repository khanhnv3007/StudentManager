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

@property (nonatomic, strong) UIPickerView *seclectTeacher;

@property (nonatomic, strong) AppDelegate *appDelegate;
@property (nonatomic, strong) NSArray *teachers;
@property (nonatomic, strong) NSMutableArray *teacherList;
@property (nonatomic, strong) Teacher *teacherIsSelected;

@end

@implementation CreateClass

- (void)init_user {
	self.teachers = [Teacher MR_findAll];
	self.teacherList = [NSMutableArray arrayWithArray:self.teachers];
}

- (void)viewDidLoad {
	[super viewDidLoad];

	[self init_user];

	self.seclectTeacher = [[UIPickerView alloc] init];
	self.seclectTeacher.dataSource = self;
	self.seclectTeacher.delegate = self;
	self.seclectTeacher.showsSelectionIndicator = YES;
	self.seclectTeacher.center = self.view.center;
	[self.view addSubview:self.seclectTeacher];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

- (IBAction)createClass:(id)sender {
	Subject *class = [Subject MR_createEntity];
	class.name = self.name.text;
	class.subjectID = [[Util sharedUtil] generateGUID];
	class.classWithTeacher = self.teacherIsSelected;
	[[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
	[[Util sharedUtil] showMessage:@"Your class has been created!" withTitle:@"Create Success"];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	if ([pickerView isEqual:self.seclectTeacher]) {
		return 1;
	}

	return 0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	if ([pickerView isEqual:self.seclectTeacher]) {
		return [self.teacherList count];
	}
	return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	if ([pickerView isEqual:self.seclectTeacher]) {
		Teacher *teacher = self.teacherList[row];
		return [NSString stringWithFormat:@"%@", teacher.name];
	}
	return nil;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	self.teacherIsSelected = self.teacherList[row];
	NSLog(@"%@", self.teacherIsSelected.name);
	self.teachername.text = self.teacherIsSelected.name;
}

@end
