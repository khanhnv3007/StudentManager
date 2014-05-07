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

	cell.imageView.image = [UIImage imageNamed:@"menu30.png"];
	Subject *class = (Subject *)[self.classList objectAtIndex:indexPath.row];
	cell.textLabel.text = class.name;
	cell.detailTextLabel.text = class.classWithTeacher.name;
	return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
	if (self.isAdmin) {
		return YES;
	}
	return NO;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		[tableView beginUpdates];

		Subject *ClassIsDeleted = [self.classList objectAtIndex:indexPath.row];
        
		[ClassIsDeleted MR_deleteEntity];
		[[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];

		[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [self loadAllClass];
        [self.rootTableView reloadData];
		[tableView endUpdates];
	}
	else if (editingStyle == UITableViewCellEditingStyleInsert) {
		// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
	}
}

//student enroll class

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isStudent) {
        [[Util sharedUtil]showMessage:@"Are you sure want to enroll this class" withTitle:@"Confirm ?" cancelButtonTitle:@"YES" otherButtonTitles:@"NO" delegate:self andTag:100];
        Subject *subject = self.classList[indexPath.row];
        self.getID = subject.subjectID;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 100) {
        if (buttonIndex == 0) {
            Subject *subject = [Subject MR_findFirstByAttribute:@"subjectID" withValue:self.getID];
            [subject addClassofStudentObject:self.student];
            //NSLog(@"ok");
        }
    }
}

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

- (IBAction)showMenu:(id)sender {
    [self.frostedViewController presentMenuViewController];
}
@end
