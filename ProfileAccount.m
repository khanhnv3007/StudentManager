//
//  ProfileAccount.m
//  StudentManager
//
//  Created by Nguyễn Nam Phong on 5/7/14.
//  Copyright (c) 2014 RoxWin. All rights reserved.
//

#import "ProfileAccount.h"
#import "AppDelegate.h"
#import "Teacher.h"
#import "Student.h"
#import "Admin.h"
#import "REFrostedViewController.h"

@interface ProfileAccount ()

@property (nonatomic, strong) AppDelegate *appDelegate;

@property (nonatomic) BOOL isAdmin;
@property (nonatomic) BOOL isTeacher;
@property (nonatomic) BOOL isStudent;

@property (nonatomic, strong) NSString *getUsername;
@property (nonatomic, strong) NSString *getPassword;

@property (nonatomic, strong) Admin *admin;
@property (nonatomic, strong) Teacher *teacher;
@property (nonatomic, strong) Student *student;

@property (nonatomic) UITextField *pass;

@end

@implementation ProfileAccount

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
	self.password.enabled = NO;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	[self init_user];
	[self showProfile];
	[self chooseImageAccount];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

- (void)showProfile {
	if (self.isAdmin) {
		self.name.text = self.admin.name;
		self.address.text = self.admin.address;
		self.phoneNumber.text = self.admin.phoneNumber;
		self.email.text = self.admin.email;
		self.username.text = self.admin.username;
		self.password.text = self.admin.password;
		if (self.admin.avatar == nil) {
			self.avatar.image = [UIImage imageNamed:@"no-avatar.png"];
		}
		else {
			self.avatar.image = [UIImage imageWithContentsOfFile:self.admin.avatar];
		}
	}
	else if (self.isTeacher) {
		self.name.text = self.teacher.name;
		self.address.text = self.teacher.address;
		self.phoneNumber.text = self.teacher.phoneNumber;
		self.email.text = self.teacher.email;
		self.username.text = self.teacher.username;
		self.password.text = self.teacher.password;
		if (self.teacher.avatar == nil) {
			self.avatar.image = [UIImage imageNamed:@"no-avatar.png"];
		}
		else {
			self.avatar.image = [UIImage imageWithContentsOfFile:self.teacher.avatar];
		}
	}
	else {
		self.name.text = self.student.name;
		self.address.text = self.student.address;
		self.phoneNumber.text = self.student.phoneNumber;
		self.email.text = self.student.email;
		self.username.text = self.student.username;
		self.password.text = self.student.password;
		if (self.student.avatar == nil) {
			self.avatar.image = [UIImage imageNamed:@"no-avatar.png"];
		}
		else {
			self.avatar.image = [UIImage imageWithContentsOfFile:self.student.avatar];
		}
	}
}

- (IBAction)showMenu:(id)sender {
	[self.frostedViewController presentMenuViewController];
}

- (BOOL)NSStringIsValidEmail:(NSString *)checkString {
	BOOL stricterFilter = YES;
	NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
	NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
	NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
	NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
	return [emailTest evaluateWithObject:checkString];
}

- (IBAction)changePassword:(id)sender {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Confirm Password" message:@"Enter your current password: " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
	alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
	[alert show];
	self.pass = [alert textFieldAtIndex:0];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 1) {
		NSLog(@"cancel");
	}
	else {
		if ([self.pass.text isEqualToString:self.admin.password]) {
			[[Util sharedUtil] showMessage:@"Now, You can change your password :)" withTitle:@"Confirm Successully!"];
			self.password.enabled = YES;
		}
	}
}

- (IBAction)Update:(id)sender {
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

	if (self.isAdmin) {
		self.admin.avatar = imagePath;
		self.admin.name = self.name.text;
		self.admin.address = self.address.text;
		if ([self NSStringIsValidEmail:self.email.text] || [self.email.text isEqualToString:@""]) {
			self.admin.email = self.email.text;
		}
		else {
			[[Util sharedUtil] showMessage:@"Your email format is invalid" withTitle:@"Update failed!"];
		}
		self.admin.username = self.username.text;
		self.admin.password = self.password.text;
		[[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
	}
	else if (self.isTeacher) {
		self.teacher.avatar = imagePath;
		self.teacher.name = self.name.text;
		self.teacher.address = self.address.text;
		if ([self NSStringIsValidEmail:self.email.text] || [self.email.text isEqualToString:@""]) {
			self.teacher.email = self.email.text;
		}
		else {
			[[Util sharedUtil] showMessage:@"Your email format is invalid" withTitle:@"Update failed!"];
		}
		self.teacher.username = self.username.text;
		self.teacher.password = self.password.text;
		[[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
	}
	else {
		self.student.avatar = imagePath;
		self.student.name = self.name.text;
		self.student.address = self.address.text;
		if ([self NSStringIsValidEmail:self.email.text] || [self.email.text isEqualToString:@""]) {
			self.student.email = self.email.text;
		}
		else {
			[[Util sharedUtil] showMessage:@"Your email format is invalid" withTitle:@"Update failed!"];
		}
		self.student.username = self.username.text;
		self.student.password = self.password.text;
		[[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
	}
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

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {
	[self.view endEditing:YES];
	[self.email resignFirstResponder];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[self.tableView resignFirstResponder];
	[self.email resignFirstResponder];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
	[self.email resignFirstResponder];
}

@end
