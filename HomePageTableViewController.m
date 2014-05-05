//
//  HomePageTableViewController.m
//  StudentManager
//
//  Created by Nguyễn Nam Phong on 5/5/14.
//  Copyright (c) 2014 RoxWin. All rights reserved.
//

#import "HomePageTableViewController.h"
#import "DataManager.h"
#import "Teacher.h"
#import "Subject.h"

@interface HomePageTableViewController ()

@property (nonatomic) BOOL isAdmin;
@property (nonatomic) BOOL isTeacher;
@property (nonatomic) BOOL isStudent;

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;

@property (nonatomic, strong) NSMutableArray *classList;
@property (nonatomic, strong) NSMutableArray *teacherList;

@end

@implementation HomePageTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initialize];
    if (self.isTeacher) {
        [self getListClass];
    }

}

- (void)initialize
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.isAdmin = appDelegate.isAdmin;
    self.isTeacher = appDelegate.isTeacher;
    self.isStudent = appDelegate.isStudent;
    
    self.username = appDelegate.username;
    self.password = appDelegate.password;
}

- (void)getListClass
{
    NSArray *class = [[DataManager sharedDataManager] getAllClass];
    self.classList = [NSMutableArray arrayWithArray:class];
    for (Subject *class in self.classList) {
        if (![class.teacher isEqual:self.username]) {
            //[self.classList delete:class];
        }
    }
    
//    
//    NSArray *mark = [[DataManager sharedDataManager]getAllMark];
//    self.classList = [NSMutableArray arrayWithArray:mark];
//    for (Mark *mark in self.classList) {
//        if (![mark.studentID isEqual:[self getStudentID]]) {
//            [self.classList delete:mark];
//        }
//    }
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

    return [self.classList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellClass" forIndexPath:indexPath];
    
    // Configure the cell...
    Subject *class = self.classList[indexPath.row];
    cell.textLabel.text = class.name;
    cell.imageView.image = [UIImage imageNamed:@"no-avatar.png"];
    
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
