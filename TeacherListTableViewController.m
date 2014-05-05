//
//  TeacherListTableViewController.m
//  StudentManager
//
//  Created by Nguyễn Nam Phong on 5/5/14.
//  Copyright (c) 2014 RoxWin. All rights reserved.
//

#import "TeacherListTableViewController.h"
#import "Teacher.h"
#import "DataManager.h"

@interface TeacherListTableViewController ()

@property (strong, nonatomic) Teacher *teacherIsDeleted;;
@property (weak, nonatomic) IBOutlet UITableView *rootTableView;
@property (strong, nonatomic) NSMutableArray *teacherList;

@end

@implementation TeacherListTableViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self loadAllTeacher];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self loadAllTeacher];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)loadAllTeacher {
	self.teacherList = [[NSMutableArray alloc] init];
	if (self.teacherList != nil) {
		[self.teacherList removeAllObjects];
		NSArray *teacherList = [[DataManager sharedDataManager] getAllTeacherAccount];
		self.teacherList = [NSMutableArray arrayWithArray:teacherList];
		[self.rootTableView reloadData];
	}
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.teacherList count];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [tableView beginUpdates];
        Teacher *teacherIsDeleted = [self.teacherList objectAtIndex:indexPath.row];
        
        [teacherIsDeleted MR_deleteEntity];
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        //[[Util sharedUtil] showMessage:@"You Sur Delete a contact" withTitle:@"Message" cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok" delegate:self andTag:1];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self loadAllTeacher];
        [self.rootTableView reloadData];
        [tableView endUpdates];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellTeacherList" forIndexPath:indexPath];
    
	Teacher *teacher = (Teacher *)[self.teacherList objectAtIndex:indexPath.row];
	if (teacher) {
		cell.textLabel.text = teacher.name;
		cell.detailTextLabel.text = teacher.username;
        if (teacher.avatar == nil) {
            cell.imageView.image = [UIImage imageNamed:@"no-avatar.png"];
        }
		else cell.imageView.image = [UIImage imageWithContentsOfFile:teacher.avatar];
	}
    
	return cell;
}
@end
