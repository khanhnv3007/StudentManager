//
//  ClassList.m
//  StudentManager
//
//  Created by Nguyễn Nam Phong on 5/7/14.
//  Copyright (c) 2014 RoxWin. All rights reserved.
//

#import "ClassList.h"
#import "AppDelegate.h"
#import "Student.h"
#import "Teacher.h"
#import "Admin.h"
#import "Subject.h"
#import "REFrostedViewController.h"
#import "Mark.h"

@interface ClassList ()

@property (nonatomic, strong) AppDelegate *appDelegate;

@property (nonatomic) BOOL isAdmin;
@property (nonatomic) BOOL isTeacher;
@property (nonatomic) BOOL isStudent;

@property (nonatomic, strong) NSString *getUsername;
@property (nonatomic, strong) NSString *getPassword;

@property (nonatomic, strong) Admin *admin;
@property (nonatomic, strong) Teacher *teacher;
@property (nonatomic, strong) Student *student;

@property (nonatomic, strong) NSMutableArray *classList;
@property (nonatomic, strong) NSArray *classes;

@property (nonatomic, strong) UITableView *rootTableView;
@property (nonatomic, strong) NSString *getID;
@property (nonatomic, strong) NSIndexPath *indexPath;

@end

@implementation ClassList

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

	self.classes = [Subject MR_findAll];
	self.classList = [NSMutableArray arrayWithArray:self.classes];
}

- (void)addButton {
	if (self.isAdmin) {
		self.navigationItem.rightBarButtonItem.enabled = YES;
	}
	else {
		self.navigationItem.rightBarButtonItem = nil;
	}
}

- (void)loadAllClass {
	self.classes = [Subject MR_findAll];
	self.classList = [NSMutableArray arrayWithArray:self.classes];
	[self.tableView reloadData];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	[self init_user];
	[self addButton];
	[self loadAllClass];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self loadAllClass];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.classList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellClassList" forIndexPath:indexPath];

	cell.imageView.image = [UIImage imageNamed:@"teacher33.png"];
	cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
	cell.imageView.clipsToBounds = YES;
	cell.imageView.layer.cornerRadius = 10.0f;
	cell.imageView.layer.masksToBounds = YES;
	cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
	Subject *class = (Subject *)[self.classList objectAtIndex:indexPath.row];
	cell.textLabel.text = class.name;
	cell.detailTextLabel.text = class.classWithTeacher.name;
	return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
	if (self.isAdmin) {
		self.indexPath = indexPath;
		return YES;
	}
	return NO;
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		[[Util sharedUtil] showMessage:@"Are you sure want to delete this class" withTitle:@"Warning!" cancelButtonTitle:@"YES" otherButtonTitles:@"NO" delegate:self andTag:1];
	}
}

//student enroll class

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (self.isStudent) {
		[[Util sharedUtil]showMessage:@"Are you sure want to enroll this class" withTitle:@"Confirm ?" cancelButtonTitle:@"YES" otherButtonTitles:@"NO" delegate:self andTag:100];
		Subject *subject = self.classList[indexPath.row];
		self.getID = subject.subjectID;
	}
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (alertView.tag == 1) {
		if (buttonIndex == 0) {
			[self.tableView beginUpdates];

			Subject *ClassIsDeleted = [self.classList objectAtIndex:self.indexPath.row];
			[ClassIsDeleted MR_deleteEntity];
			[[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];

			[self.tableView deleteRowsAtIndexPaths:@[self.indexPath] withRowAnimation:UITableViewRowAnimationFade];

			[self loadAllClass];
			[self.rootTableView reloadData];
			[self.tableView endUpdates];
		}
	}
	if (alertView.tag == 100) {
		if (buttonIndex == 0) {
			Subject *subject = [Subject MR_findFirstByAttribute:@"subjectID" withValue:self.getID];
			[subject addClassofStudentObject:self.student];
			Mark *markOfStudent = [Mark MR_createEntity];
			markOfStudent.markID = [[Util sharedUtil]generateGUID];
			markOfStudent.mid = 0;
			markOfStudent.final = 0;
			markOfStudent.average = 0;
			markOfStudent.markOfStudent = self.student;
			markOfStudent.markOfSubject = subject;
			[subject addSubjectOfMarkObject:markOfStudent];
			[[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
		}
	}
}

- (IBAction)showMenu:(id)sender {
	[self.frostedViewController presentMenuViewController];
}

@end
