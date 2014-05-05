//
//  ClassListTableViewController.m
//  StudentManager
//
//  Created by Nguyễn Nam Phong on 5/5/14.
//  Copyright (c) 2014 RoxWin. All rights reserved.
//

#import "ClassListTableViewController.h"
#import "DataManager.h"
#import "Subject.h"
#import "SubjectModel.h"
#import "AppDelegate.h"
#import "MarkModel.h"
#import "Student.h"

@interface ClassListTableViewController ()

@property (nonatomic, strong) NSMutableArray *classList;
@property (weak, nonatomic) IBOutlet UITableView *rootTableView;
@property ( nonatomic) NSInteger classIsSelected;
//@property (strong, nonatomic) Subject *classIsDeleted;

@end

@implementation ClassListTableViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self addButton];
	[self loadAddClass];
}

- (void)viewWillAppear:(BOOL)animated {
	[self loadAddClass];
	[self addButton];
}

- (void)addButton {
	AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
	if (appDelegate.isAdmin) {
		self.navigationItem.rightBarButtonItem.enabled = YES;
	}
	if (appDelegate.isStudent || appDelegate.isTeacher) {
		self.navigationItem.rightBarButtonItem = nil;
	}
}

- (void)loadAddClass {
	self.classList = [[NSMutableArray alloc] init];
	if (self.classList != nil) {
		[self.classList removeAllObjects];
		NSArray *classList = [[DataManager sharedDataManager] getAllClass];
		self.classList = [NSMutableArray arrayWithArray:classList];
		[self.rootTableView reloadData];
	}
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
	return [self.classList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *cellIdentifier = @"cellClassList";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];

	Subject *subject = nil;
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
	}
	subject = (Subject *)[self.classList objectAtIndex:indexPath.row];

	if (subject) {
		cell.imageView.image = [UIImage imageNamed:@"menu30.png"];
		cell.textLabel.text = subject.name;
		cell.detailTextLabel.text = subject.teacher;
	}
	return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.classIsSelected = indexPath.row;
	[tableView deselectRowAtIndexPath:indexPath animated:NO];
	[[Util sharedUtil] showMessage:@"Are you sure want to enroll this class" withTitle:@"Message" cancelButtonTitle:@"YES" otherButtonTitles:@"NO" delegate:self andTag:100];
}

- (NSString *)getStudentID {
	NSArray *student = [[DataManager sharedDataManager]getAllStudentAccount];
	NSMutableArray *studentList = [NSMutableArray arrayWithArray:student];
	AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];

	for (Student *student in studentList) {
		if ([student.username isEqual:appDelegate.username]) {
			return student.studentID;
		}
	}
	return nil;
}

- (NSString *)getClassID
{
    Subject *class = (Subject *)[self.classList objectAtIndex:self.classIsSelected];
    return class.subjectID;
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (alertView.tag == 100) {
		if (buttonIndex == 0) {
			MarkModel *markModel = [[DataManager sharedDataManager] createMarkModelWithStudentID:[self getStudentID] classID:[self getClassID] Mid:nil Final:nil Average:nil];
			NSLog(@"OK");
			[markModel managedObject];
		}
		else {
			NSLog(@"Nothing");
		}
	}
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		[tableView beginUpdates];
        Subject *classIsDeleted = [self.classList objectAtIndex:indexPath.row];

		[classIsDeleted MR_deleteEntity];
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
		//[[Util sharedUtil] showMessage:@"You Sur Delete a contact" withTitle:@"Message" cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok" delegate:self andTag:1];
		[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self loadAddClass];
		[self.rootTableView reloadData];
		[tableView endUpdates];
	}
}

@end
