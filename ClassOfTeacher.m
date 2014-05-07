//
//  ClassOfTeacher.m
//  StudentManager
//
//  Created by Nguyễn Nam Phong on 5/7/14.
//  Copyright (c) 2014 RoxWin. All rights reserved.
//

#import "ClassOfTeacher.h"
#import "Teacher.h"
#import "Subject.h"
#import "Student.h"
#import "AppDelegate.h"
#import "Admin.h"

@interface ClassOfTeacher ()

@property (strong, nonatomic) NSMutableArray *classList;
@property (strong, nonatomic) NSArray *classes;

@property (nonatomic, strong) AppDelegate *appDelegate;

@property (nonatomic) BOOL isAdmin;
@property (nonatomic) BOOL isTeacher;
@property (nonatomic) BOOL isStudent;

@property (nonatomic, strong) NSString *getUsername;
@property (nonatomic, strong) NSString *getPassword;

@property (nonatomic, strong) Admin *admin;
@property (nonatomic, strong) Teacher *teacher;
@property (nonatomic, strong) Student *student;


@property (nonatomic, strong) UITableView *rootTableView;


@end

@implementation ClassOfTeacher

- (void)init_user
{
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
	self.isAdmin = self.appDelegate.isAdmin;
	self.isStudent = self.appDelegate.isStudent;
	self.isTeacher = self.appDelegate.isTeacher;
    
	self.getPassword = self.appDelegate.password;
	self.getUsername = self.appDelegate.username;
    
	self.admin = [Admin MR_findFirstByAttribute:@"username" withValue:self.getUsername];
	self.teacher = [Teacher MR_findFirstByAttribute:@"username" withValue:self.getUsername];
	self.student = [Student MR_findFirstByAttribute:@"username" withValue:self.getUsername];
    
	self.classes = [self.teacher.teacherinClass allObjects];
	self.classList = [NSMutableArray arrayWithArray:self.classes];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self init_user];
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
    return [self.classList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellClass" forIndexPath:indexPath];
    
    Subject *class = self.classList[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"menu30.png"];
    cell.textLabel.text = class.name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Subject *class = self.classList[indexPath.row];
    self.appDelegate.currentClass = class.name;
}
@end
