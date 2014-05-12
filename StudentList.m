//
//  StudentList.m
//  StudentManager
//
//  Created by Nguyễn Nam Phong on 5/7/14.
//  Copyright (c) 2014 RoxWin. All rights reserved.
//

#import "StudentList.h"
#import "Student.h"
#import "AppDelegate.h"
#import "Admin.h"
#import "Teacher.h"
#import "REFrostedViewController.h"

@interface StudentList ()

@property (nonatomic, strong) AppDelegate *appDelegate;

@property (nonatomic) BOOL isAdmin;
@property (nonatomic) BOOL isTeacher;
@property (nonatomic) BOOL isStudent;

@property (nonatomic, strong) NSString *getUsername;
@property (nonatomic, strong) NSString *getPassword;

@property (nonatomic, strong) Admin *admin;
@property (nonatomic, strong) Teacher *teacher;
@property (nonatomic, strong) Student *student;

@property (nonatomic, strong) NSMutableArray *studentList;
@property (nonatomic, strong) NSArray *students;

@property (nonatomic, strong) UITableView *rootTableView;
@property (nonatomic, strong) NSIndexPath *indexPath;

@end

@implementation StudentList

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

	self.students = [Student MR_findAll];
	self.studentList = [NSMutableArray arrayWithArray:self.students];
}

- (void)loadAllStudent {
	self.students = [Student MR_findAll];
	self.studentList = [NSMutableArray arrayWithArray:self.students];
	[self.tableView reloadData];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	[self init_user];
	[self loadAllStudent];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.studentList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellStudentList" forIndexPath:indexPath];

	Student *student = self.studentList[indexPath.row];
	if (student.avatar == nil) {
		cell.imageView.image = [UIImage imageNamed:@"no-avatar.png"];
	}
	else {
		cell.imageView.image = [UIImage imageWithContentsOfFile:student.avatar];
		cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
		cell.imageView.clipsToBounds = YES;
		cell.imageView.layer.cornerRadius = 10.0f;
		cell.imageView.layer.masksToBounds = YES;
	}

	cell.textLabel.text = student.name;
	cell.detailTextLabel.text = student.username;

	return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
	if (self.isAdmin) {
		self.indexPath = indexPath;
		return YES;
	}
	return NO;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		[[Util sharedUtil] showMessage:@"Are you sure want to delete this student?" withTitle:@"Warning!" cancelButtonTitle:@"YES" otherButtonTitles:@"NO" delegate:self andTag:3];
	}
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (alertView.tag == 3) {
		if (buttonIndex == 0) {
			[self.tableView beginUpdates];

			Student *studentIsDeleted = [self.studentList objectAtIndex:self.indexPath.row];

			[studentIsDeleted MR_deleteEntity];
			[[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];

			[self.tableView deleteRowsAtIndexPaths:@[self.indexPath] withRowAnimation:UITableViewRowAnimationFade];

			[self loadAllStudent];
			[self.rootTableView reloadData];
			[self.tableView endUpdates];
		}
	}
}

- (IBAction)showMenu:(id)sender {
	[self.frostedViewController presentMenuViewController];
}

@end
