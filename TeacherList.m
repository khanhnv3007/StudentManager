//
//  TeacherList.m
//  StudentManager
//
//  Created by Nguyễn Nam Phong on 5/7/14.
//  Copyright (c) 2014 RoxWin. All rights reserved.
//

#import "TeacherList.h"
#import "Admin.h"
#import "Teacher.h"
#import "Student.h"
#import "AppDelegate.h"

@interface TeacherList ()

@property (nonatomic, strong) AppDelegate *appDelegate;

@property (nonatomic) BOOL isAdmin;
@property (nonatomic) BOOL isTeacher;
@property (nonatomic) BOOL isStudent;

@property (nonatomic, strong) NSString *getUsername;
@property (nonatomic, strong) NSString *getPassword;

@property (nonatomic, strong) Admin *admin;
@property (nonatomic, strong) Teacher *teacher;
@property (nonatomic, strong) Student *student;

@property (nonatomic, strong) NSMutableArray *teacherList;
@property (nonatomic, strong) NSArray *teachers;

@property (nonatomic, strong) UITableView *rootTableView;
@property (nonatomic, strong) NSIndexPath *indexPath;

@end

@implementation TeacherList

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
    
	self.teachers = [Teacher MR_findAll];
	self.teacherList = [NSMutableArray arrayWithArray:self.teachers];
}

- (void)loadAllTeacher
{
    self.teachers = [Teacher MR_findAll];
    self.teacherList = [NSMutableArray arrayWithArray:self.teachers];
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self init_user];
    [self loadAllTeacher];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.teacherList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellTeacherList" forIndexPath:indexPath];
    
    Teacher *teacher = self.teacherList[indexPath.row];
    if (teacher.avatar == nil) {
        cell.imageView.image = [UIImage imageNamed:@"no-avatar.png"];
    } else {
        cell.imageView.image = [UIImage imageWithContentsOfFile:teacher.avatar];
    }
    
    cell.textLabel.text = teacher.name;
    cell.detailTextLabel.text = teacher.username;
    
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
        [[Util sharedUtil] showMessage:@"Are you sure want to delete this teacher?" withTitle:@"Warning!" cancelButtonTitle:@"Yes" otherButtonTitles:@"NO" delegate:self andTag:2];
	}
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 2) {
        if (buttonIndex == 0) {
            [self.tableView beginUpdates];
            Teacher *TeacherIsDeleted = [self.teacherList objectAtIndex:self.indexPath.row];
            [TeacherIsDeleted MR_deleteEntity];
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
            [self.tableView deleteRowsAtIndexPaths:@[self.indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self loadAllTeacher];
            [self.rootTableView reloadData];
            [self.tableView endUpdates];
        }
    }
}

@end
