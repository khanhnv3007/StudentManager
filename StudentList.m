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

- (void)loadAllStudent
{
    self.students = [Student MR_findAll];
    self.studentList = [NSMutableArray arrayWithArray:self.students];
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self init_user];
    [self loadAllStudent];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.studentList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellStudentList" forIndexPath:indexPath];
    
    Student *student = self.studentList[indexPath.row];
    if (student.avatar == nil) {
        cell.imageView.image = [UIImage imageNamed:@"no-avatar.png"];
    } else {
        cell.imageView.image = [UIImage imageWithContentsOfFile:student.avatar];
    }
    
    cell.textLabel.text = student.name;
    cell.detailTextLabel.text = student.username;
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
