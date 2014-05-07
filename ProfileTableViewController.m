//
//  ProfileTableViewController.m
//  StudentManager
//
//  Created by Nguyễn Nam Phong on 5/5/14.
//  Copyright (c) 2014 RoxWin. All rights reserved.
//

#import "ProfileTableViewController.h"
#import "DataManager.h"
#import "Student.h"
#import "AppDelegate.h"
#import "Admin.h"
#import "Teacher.h"

@interface ProfileTableViewController ()

@property (nonatomic, strong) NSMutableArray *adminList;
@property (nonatomic, strong) NSMutableArray *studentList;
@property (nonatomic, strong) NSMutableArray *teacherList;

@property (nonatomic, strong) NSString *getUserName;
@property (nonatomic, strong) NSString *getPassword;
@property (nonatomic) BOOL isAdmin;
@property (nonatomic) BOOL isTeacher;
@property (nonatomic) BOOL isStudent;


@end

@implementation ProfileTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self init_user_type];
    [self getAccount];
    [self showInfo];
    [self chooseImageAccount];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)init_user_type{
    AppDelegate * appdelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    self.isAdmin = appdelegate.isAdmin;
    self.isTeacher = appdelegate.isTeacher;
    self.isStudent = appdelegate.isStudent;}

- (void)getAccount
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.getUserName = appDelegate.username;
    self.getPassword = appDelegate.password;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showMenu:(id)sender {
    [self.view endEditing:YES];
    [self.frostedViewController presentMenuViewController];
}

- (IBAction)update:(id)sender {
    NSData *imageData = UIImagePNGRepresentation(self.avatar.image);
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *cache = [[Util sharedUtil] generateGUID];
	NSString *imagePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", cache]];
	NSLog((@"pre writing to file"));
	if (![imageData writeToFile:imagePath atomically:NO]) {
		DLog(@"Failed to cache image data to disk");
	}
	else {
		DLog(@"the cachedImagedPath is %@", imagePath);
	}
    if(self.isStudent){
        for (Student *student in self.studentList) {
            if ([student.username isEqual:self.getUserName]) {
                student.name = self.name.text;
                if([self NSStringIsValidEmail:self.email.text]){
                    student.email = self.email.text;
                }else{
                    [[Util sharedUtil] showMessage:@"Your email format is invalid" withTitle:@"Update failed!"];
                }
                student.avatar = imagePath;
                student.phoneNumber = self.phoneNumber.text;
                student.address = self.address.text;
                student.password = self.password.text;
            }
        }

    }
    
    if(self.isAdmin){
        for (Admin *admin in self.adminList) {
            if ([admin.username isEqual:self.getUserName]) {
                admin.name = self.name.text;
                admin.address = self.address.text;
                admin.phoneNumber = self.phoneNumber.text;
                admin.username = self.username.text;
                admin.password = self.password.text;
                if([self NSStringIsValidEmail:self.email.text]){
                    admin.email = self.email.text;
                    NSLog(@"ok");
                }else{
                    [[Util sharedUtil] showMessage:@"Your email format is invalid" withTitle:@"Update failed!"];
                    NSLog(@"fail");
                }
                admin.avatar = imagePath;
            }
        }
    }
    
    if (self.isTeacher) {
        for (Teacher *teacher in self.teacherList) {
            if ([teacher.username isEqual:self.getUserName]) {
                teacher.name = self.name.text;
                if([self NSStringIsValidEmail:self.email.text]){
                    teacher.email = self.email.text;
                    NSLog(@"ok");
                }else{
                    [[Util sharedUtil] showMessage:@"Your email format is invalid" withTitle:@"Update failed!"];
                    NSLog(@"fail");
                }
                teacher.avatar = imagePath;
                teacher.phoneNumber = self.phoneNumber.text;
                teacher.address = self.address.text;
                teacher.password = self.password.text;
            }
        }
    }
}

-(void)showInfo{
    if(self.isAdmin){
        NSArray * admin = [[DataManager sharedDataManager]getAllAdminAccount];
        self.adminList = [NSMutableArray arrayWithArray:admin];
        
        for (Admin* currentAdmin in self.adminList) {
            if ([currentAdmin.username isEqual:self.getUserName] && [currentAdmin.password isEqual:self.getPassword]) {
                if (currentAdmin.avatar == nil) {
                    self.avatar.image = [UIImage imageNamed:@"no-avatar.png"];
                } else {
                    self.avatar.image = [UIImage imageWithContentsOfFile:currentAdmin.avatar];
                }
                
                self.name.text = currentAdmin.name;
                self.birthday.text = [[Util sharedUtil]getStringFromDate:currentAdmin.birthday];
                self.address.text = currentAdmin.address;
                self.email.text = currentAdmin.email;
                self.phoneNumber.text = currentAdmin.phoneNumber;
                
                self.username.text = currentAdmin.username;
                self.password.text = currentAdmin.password;
            }
        }
    }
    
    if (self.isTeacher) {
        NSArray * teacher = [[DataManager sharedDataManager]getAllTeacherAccount];
        self.teacherList = [NSMutableArray arrayWithArray:teacher];
        
        for (Teacher* currentTeacher in self.teacherList) {
            if ([currentTeacher.username isEqual:self.getUserName] && [currentTeacher.password isEqual:self.getPassword]) {
                if (currentTeacher.avatar == nil) {
                    self.avatar.image = [UIImage imageNamed:@"no-avatar.png"];
                } else {
                    self.avatar.image = [UIImage imageWithContentsOfFile:currentTeacher.avatar];
                }
                
                self.name.text = currentTeacher.name;
                self.birthday.text = [[Util sharedUtil]getStringFromDate:currentTeacher.birthday];
                self.address.text = currentTeacher.address;
                self.email.text = currentTeacher.email;
                self.phoneNumber.text = currentTeacher.phoneNumber;
                
                self.username.text = currentTeacher.username;
                self.password.text = currentTeacher.password;
            }
        }
    }
    
    if (self.isStudent) {
        NSArray * student = [[DataManager sharedDataManager]getAllStudentAccount];
        self.studentList = [NSMutableArray arrayWithArray:student];
        
        for (Student* currentStudent in self.studentList) {
            if ([currentStudent.username isEqual:self.getUserName] && [currentStudent.password isEqual:self.getPassword]) {
                if (currentStudent.avatar == nil) {
                    self.avatar.image = [UIImage imageNamed:@"no-avatar.png"];
                } else {
                    self.avatar.image = [UIImage imageWithContentsOfFile:currentStudent.avatar];
                }
                
                self.name.text = currentStudent.name;
                self.birthday.text = [[Util sharedUtil]getStringFromDate:currentStudent.birthday];
                self.address.text = currentStudent.address;
                self.email.text = currentStudent.email;
                self.phoneNumber.text = currentStudent.phoneNumber;
                
                self.username.text = currentStudent.username;
                self.password.text = currentStudent.password;
            }
        }
        
    }

}

-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

- (NSString *)savePathLocalImage:(UIImage *)image {
	NSString *pathImage = [[NSString alloc] init];
	return pathImage;
}

- (void)chooseImageAccount {
	UITapGestureRecognizer *tapAtImage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(newTapMethod)];
	[self.avatar setUserInteractionEnabled:YES];
	[self.avatar addGestureRecognizer:tapAtImage];
}

- (void)newTapMethod {
	[self showActionChooseImage];
}

- (void)showActionChooseImage {
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Title" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take photo", @"Choose from library", nil];
	[actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
	UIImagePickerController *picker = [[UIImagePickerController alloc] init];
	picker.modalPresentationStyle = UIModalPresentationCurrentContext;
	picker.delegate = self;
	picker.allowsEditing = YES;
	if ([buttonTitle isEqualToString:@"Take photo"]) {
		if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
			picker.sourceType = UIImagePickerControllerSourceTypeCamera;
		}
		[self presentViewController:picker animated:YES completion:NULL];
	}
	else if ([buttonTitle isEqualToString:@"Choose from library"]) {
		UIImagePickerController *picker = [[UIImagePickerController alloc] init];
		picker.delegate = self;
		picker.allowsEditing = YES;
		picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
		[self presentViewController:picker animated:YES completion:NULL];
	}
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
	[picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
	self.avatar.image = chosenImage;
    
	[picker dismissViewControllerAnimated:YES completion:NULL];
}
@end
