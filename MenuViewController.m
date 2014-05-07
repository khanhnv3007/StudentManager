//
//  MenuViewController.m
//  StudentManager
//
//  Created by Nguyễn Nam Phong on 4/24/14.
//  Copyright (c) 2014 Phongnn. All rights reserved.
//

#import "MenuViewController.h"
#import "REFrostedViewController.h"


#import "NavigationController.h"
#import "UIViewController+REFrostedViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "Admin.h"
#import "Teacher.h"
#import "Student.h"
#import "ProfileAccount.h"

@interface MenuViewController ()

@property (nonatomic) BOOL isAdmin;
@property (nonatomic) BOOL isTeacher;
@property (nonatomic) BOOL isStudent;

@property (nonatomic, strong) NSString *nameOfUser;

@end


@implementation MenuViewController

- (NSString *)getUserName {
	AppDelegate *apdelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
	return apdelegate.username;
}

- (void)initialize {
	self.isAdmin = NO;
	self.isTeacher = NO;
	self.isStudent = NO;
}

- (void)checkAuthen {
	AppDelegate *apdelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
	self.isAdmin = apdelegate.isAdmin;
	self.isTeacher = apdelegate.isTeacher;
	self.isStudent = apdelegate.isStudent;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewDidLoad];
}

//- (NSString *)getImagePath {
//	AppDelegate *apdelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
//	NSString *imagePath = nil;
//    
//	NSArray *admin = [[DataManager sharedDataManager] getAllAdminAccount];
//	NSMutableArray *adminList = [NSMutableArray arrayWithArray:admin];
//
//    NSArray *teacher = [[DataManager sharedDataManager] getAllTeacherAccount];
//    NSMutableArray *teacherList = [NSMutableArray arrayWithArray:teacher];
//    
//	for (Admin *currentAdmin in adminList) {
//		if ([currentAdmin.username isEqual:apdelegate.username]) {
//			imagePath = currentAdmin.avatar;
//            self.nameOfUser = currentAdmin.name;
//		}
//	}
//    
//    for ( Teacher *currentTeacher in teacherList) {
//		if ([currentTeacher.username isEqual:apdelegate.username]) {
//			imagePath = currentTeacher.avatar;
//            self.nameOfUser = currentTeacher.name;
//		}
//	}
//    
//    NSArray *student = [[DataManager sharedDataManager]getAllStudentAccount];
//    NSMutableArray *studentList = [NSMutableArray arrayWithArray:student];
//    
//    for (Student *currentStudent in studentList) {
//        if ([currentStudent.username isEqual:apdelegate.username]) {
//            imagePath = currentStudent.avatar;
//            self.nameOfUser = currentStudent.name;
//        }
//    }
//    
//	return imagePath;
//}

- (void)viewDidLoad {
	[super viewDidLoad];

	[self initialize];
    [self checkAuthen];

	self.tableView.separatorColor = [UIColor colorWithRed:150 / 255.0f green:161 / 255.0f blue:177 / 255.0f alpha:1.0f];
	self.tableView.delegate = self;
	self.tableView.dataSource = self;
	self.tableView.opaque = NO;
	self.tableView.backgroundColor = [UIColor clearColor];
	self.tableView.tableHeaderView = ({
	                                      UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 184.0f)];
	                                      view.backgroundColor = [UIColor colorWithRed:28.0 / 255 green:158.0 / 255 blue:121.0 / 255 alpha:1.0f];
	                                      UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50, 100, 100)];
	                                      imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
//        if ([self getImagePath] == nil) {
//            imageView.image = [UIImage imageNamed:@"no-avatar.png"];
//        } else {
//            imageView.image =  [UIImage imageWithContentsOfFile:[self getImagePath]];
//        }
	                                      imageView.layer.masksToBounds = YES;
	                                      imageView.layer.cornerRadius = 50.0;
	                                      imageView.layer.borderColor = [UIColor whiteColor].CGColor;
	                                      imageView.layer.borderWidth = 3.0f;
	                                      imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
	                                      imageView.layer.shouldRasterize = YES;
	                                      imageView.clipsToBounds = YES;

	                                      UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, 0, 24)];
	                                      label.text = [NSString stringWithFormat:@"Welcome %@", self.nameOfUser];
	                                      label.backgroundColor = [UIColor clearColor];
	                                      label.textColor = [UIColor colorWithRed:62 / 255.0f green:68 / 255.0f blue:75 / 255.0f alpha:1.0f];
	                                      [label sizeToFit];
	                                      label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;

	                                      [view addSubview:imageView];
	                                      [view addSubview:label];
	                                      view;
									  });
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	cell.backgroundColor = [UIColor clearColor];
	cell.textLabel.textColor = [UIColor colorWithRed:62 / 255.0f green:68 / 255.0f blue:75 / 255.0f alpha:1.0f];
	cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionIndex {
	if (sectionIndex == 0)
		return nil;
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 34)];
	view.backgroundColor = [UIColor colorWithRed:167 / 255.0f green:167 / 255.0f blue:167 / 255.0f alpha:0.6f];

	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 0, 0)];
	label.text = @"Setting";
	label.font = [UIFont systemFontOfSize:15];
	label.textColor = [UIColor whiteColor];
	label.backgroundColor = [UIColor clearColor];
	[label sizeToFit];
	[view addSubview:label];

	return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex {
	if (sectionIndex == 0)
		return 0;

	return 34;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	NavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"navController"];
    
    if (indexPath.section == 0 && indexPath.row == 1) {
        ProfileAccount *profile = [self.storyboard instantiateViewControllerWithIdentifier:@"profile"];
        navigationController.viewControllers = @[profile];
    }
//
//	if (indexPath.section == 0 && indexPath.row == 0) {
//		HomePageTableViewController *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"homeController"];
//		navigationController.viewControllers = @[homeViewController];
//	}
//	else if (indexPath.section == 0 && indexPath.row == 1) {
//		NSLog(@"OK");
//		ProfileTableViewController *profile = [self.storyboard instantiateViewControllerWithIdentifier:@"profile"];
//		navigationController.viewControllers = @[profile];
//	}
//    
//    if ((indexPath.section == 1 && indexPath.row == 1 && self.isStudent) || (self.isAdmin && indexPath.section == 1 && indexPath.row == 0)) {
//        ClassListTableViewController *classList = [self.storyboard instantiateViewControllerWithIdentifier:@"classList"];
//        navigationController.viewControllers = @[classList];
//    }
//    
//    if (self.isStudent && indexPath.section == 1 && indexPath.row == 0) {
//        ClassOfStudentTableViewController *classOfStudent = [self.storyboard instantiateViewControllerWithIdentifier:@"classOfStudent"];
//        navigationController.viewControllers = @[classOfStudent];
//    }
//    
//    if (self.isAdmin && indexPath.section == 1 && indexPath.row == 1) {
//        ManagePeopleTableViewController *managePeople = [self.storyboard instantiateViewControllerWithIdentifier:@"managePeople"];
//        navigationController.viewControllers = @[managePeople];
//    }
//    
    if (((self.isAdmin || self.isStudent) && (indexPath.section == 1 && indexPath.row == 2)) || (self.isTeacher && indexPath.section == 1 && indexPath.row == 1)) {
            UIStoryboard *loginStoryboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
            UINavigationController *navController = [loginStoryboard instantiateInitialViewController];
            self.view.window.rootViewController = navController;
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        appDelegate.isAdmin = NO;
        appDelegate.isTeacher = NO;
        appDelegate.isStudent = NO;
   }
//
	self.frostedViewController.contentViewController = navigationController;
	[self.frostedViewController hideMenuViewController];
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 54;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex {
    if (self.isAdmin || self.isStudent) {
        if (sectionIndex == 0) {
            return 2;
        }
        return 3;
    }
        return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *cellIdentifier = @"Cell";

	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
	}

	if (indexPath.section == 0) {
		NSArray *titles = @[@"Home", @"Account"];
		cell.textLabel.text = titles[indexPath.row];
	}
	else {
        NSArray *titles = [[NSArray alloc]init];
        if (self.isAdmin) {
            titles = @[@"Manage Class", @"Manage Teacher - Student", @"Sign out"];
        }
        if (self.isTeacher) {
            titles = @[@"Your Class",@"Sign out"];
        }
        if (self.isStudent) {
            titles = @[@"Your Class", @"Find Class", @"Sign out"];
        }

		cell.textLabel.text = titles[indexPath.row];
	}

	return cell;
}

@end
