//
//  ProfileAccount.m
//  StudentManager
//
//  Created by Nguyễn Nam Phong on 5/7/14.
//  Copyright (c) 2014 RoxWin. All rights reserved.
//

#import "ProfileAccount.h"
#import "AppDelegate.h"
#import "Teacher.h"
#import "Student.h"
#import "Admin.h"
#import "REFrostedViewController.h"

@interface ProfileAccount ()

@property (nonatomic, strong) AppDelegate *appDelegate;

@property (nonatomic) BOOL isAdmin;
@property (nonatomic) BOOL isTeacher;
@property (nonatomic) BOOL isStudent;

@property (nonatomic, strong) NSString *getUsername;
@property (nonatomic, strong) NSString *getPassword;

@property (nonatomic, strong) Admin *admin;
@property (nonatomic, strong) Teacher *teacher;
@property (nonatomic, strong) Student *student;

@end

@implementation ProfileAccount

- (void)init_user {
	self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
	self.isAdmin = self.appDelegate.isAdmin;
	self.isStudent = self.appDelegate.isStudent;
	self.isTeacher = self.appDelegate.isTeacher;

	self.getPassword = self.appDelegate.password;
	self.getUsername = self.appDelegate.username;

	self.admin = [Admin MR_findFirstByAttribute:@"username" withValue:self.getUsername];
	self.teacher = [Teacher MR_findFirstByAttribute:@"username" withValue:self.getUsername];
	self.student = [Student MR_findFirstByAttribute:@"username" withValue:self.getUsername];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	[self init_user];
	[self showProfile];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

- (void)showProfile {
	if (self.isAdmin) {
		self.name.text = self.admin.name;
		self.address.text = self.admin.address;
		self.phoneNumber.text = self.admin.phoneNumber;
		self.email.text = self.admin.email;
		self.username.text = self.admin.username;
		self.password.text = self.admin.password;
		self.avatar.image = [UIImage imageWithContentsOfFile:self.admin.avatar];
	}
	else if (self.isTeacher) {
		self.name.text = self.teacher.name;
		self.address.text = self.teacher.address;
		self.phoneNumber.text = self.teacher.phoneNumber;
		self.email.text = self.teacher.email;
		self.username.text = self.teacher.username;
		self.password.text = self.teacher.password;
		self.avatar.image = [UIImage imageWithContentsOfFile:self.teacher.avatar];
	}
	else {
		self.name.text = self.student.name;
		self.address.text = self.student.address;
		self.phoneNumber.text = self.student.phoneNumber;
		self.email.text = self.student.email;
		self.username.text = self.student.username;
		self.password.text = self.student.password;
		self.avatar.image = [UIImage imageWithContentsOfFile:self.student.avatar];
	}
}

- (IBAction)showMenu:(id)sender {
	[self.frostedViewController presentMenuViewController];
}

- (BOOL)NSStringIsValidEmail:(NSString *)checkString {
	BOOL stricterFilter = YES;
	NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
	NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
	NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
	NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
	return [emailTest evaluateWithObject:checkString];
}

- (IBAction)Update:(id)sender {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *cache = [[Util sharedUtil] generateGUID];
	NSString *imagePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", cache]];

	if (self.isAdmin) {
		self.admin.avatar = imagePath;
		self.admin.name = self.name.text;
		self.admin.address = self.address.text;
		if ([self NSStringIsValidEmail:self.email.text] || [self.email.text isEqualToString:@""]) {
			self.admin.email = self.email.text;
		}
		else {
			[[Util sharedUtil] showMessage:@"Your email format is invalid" withTitle:@"Update failed!"];
		}
		self.admin.username = self.username.text;
		self.admin.password = self.password.text;
	}
	else if (self.isTeacher) {
		self.teacher.avatar = imagePath;
		self.teacher.name = self.name.text;
		self.teacher.address = self.address.text;
		if ([self NSStringIsValidEmail:self.email.text] || [self.email.text isEqualToString:@""]) {
			self.teacher.email = self.email.text;
		}
		else {
			[[Util sharedUtil] showMessage:@"Your email format is invalid" withTitle:@"Update failed!"];
		}
		self.teacher.username = self.username.text;
		self.teacher.password = self.password.text;
    }
	else {
		self.student.avatar = imagePath;
		self.student.name = self.name.text;
		self.student.address = self.address.text;
		if ([self NSStringIsValidEmail:self.email.text] || [self.email.text isEqualToString:@""]) {
			self.student.email = self.email.text;
		}
		else {
			[[Util sharedUtil] showMessage:@"Your email format is invalid" withTitle:@"Update failed!"];
		}
		self.student.username = self.username.text;
		self.student.password = self.password.text;
	}
}

@end
