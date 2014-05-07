//
//  MarkOfClass.m
//  StudentManager
//
//  Created by Nguyễn Nam Phong on 5/7/14.
//  Copyright (c) 2014 RoxWin. All rights reserved.
//

#import "MarkOfClass.h"
#import "Subject.h"
#import "Student.h"
#import "Teacher.h"
#import "AppDelegate.h"
#import "StudentMarkCell.h"

@interface MarkOfClass ()

@property (nonatomic, strong) AppDelegate *appDelegate;
@property (nonatomic, strong) NSArray *students;
@property (nonatomic, strong) NSMutableArray *studentList;

@property (nonatomic, strong) Subject *currentClass;

@end

@implementation MarkOfClass

- (void)init_properties
{
    self.appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    self.currentClass = [Subject MR_findFirstByAttribute:@"name" withValue:self.appDelegate.currentClass];
    self.students = [self.currentClass.classofStudent allObjects];
    self.studentList = [NSMutableArray arrayWithArray:self.students];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self init_properties];
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

    return [self.studentList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cellClassMark";
	StudentMarkCell *cell = (StudentMarkCell *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
	[cell setCellHeight:cell.frame.size.height];
	cell.containingTableView = tableView;

	Student *currentStudent = self.studentList[indexPath.row];
    cell.student = currentStudent;

    cell.delegate = self;
	return cell;
}


@end
