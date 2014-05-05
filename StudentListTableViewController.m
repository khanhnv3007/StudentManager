//
//  StudentList.m
//  StudentManager
//
//  Created by Nguyễn Nam Phong on 5/3/14.
//  Copyright (c) 2014 Phongnn. All rights reserved.
//

#import "StudentListTableViewController.h"
#import "Student.h"
#import "DataManager.h"

@interface StudentListTableViewController ()

@property (strong, nonatomic) Student *studentIsDeleted;
@property (weak, nonatomic) IBOutlet UITableView *rootTableView;
@property (strong, nonatomic) NSMutableArray *studentList;
@end

@implementation StudentListTableViewController


- (void)viewDidLoad {
	[super viewDidLoad];
	[self loadAllStudent];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self loadAllStudent];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)loadAllStudent {
	self.studentList = [[NSMutableArray alloc] init];
	if (self.studentList != nil) {
		[self.studentList removeAllObjects];
		NSArray *studentList = [[DataManager sharedDataManager]getAllStudentAccount];
		self.studentList = [NSMutableArray arrayWithArray:studentList];
		[self.rootTableView reloadData];
	}
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
    
	Student *student = (Student *)[self.studentList objectAtIndex:indexPath.row];
	if (student) {
		cell.textLabel.text = student.name;
		cell.detailTextLabel.text = student.username;
        if (student.avatar == nil) {
            cell.imageView.image = [UIImage imageNamed:@"no-avatar.png"];
        }
		else cell.imageView.image = [UIImage imageWithContentsOfFile:student.avatar];
	}
    
	return cell;
}

@end
