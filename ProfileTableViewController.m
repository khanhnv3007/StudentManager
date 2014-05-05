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

@property (nonatomic, strong) NSMutableArray *List;
@property (nonatomic, strong) NSString *getUserName;
@property (nonatomic, strong) NSString *getPassword;

@end

@implementation ProfileTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    AppDelegate *appdelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    if(appdelegate.isStudent){
        [self updateStudent];
    }
    if(appdelegate.isAdmin){
        [self updateAdmin];
    }
    
    if (appdelegate.isTeacher) {
        [self updateTeacher];
    }
}

-(void)updateTeacher{
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
    
	for (Teacher *teacher in self.List) {
		if ([teacher.username isEqual:self.getUserName]) {
			teacher.name = self.name.text;
            teacher.email = self.email.text;
			teacher.avatar = imagePath;
			teacher.phoneNumber = self.phoneNumber.text;
			teacher.address = self.address.text;
			teacher.password = self.password.text;
		}
	}

}

-(void)updateStudent{
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
    
	for (Student *student in self.List) {
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

-(void)updateAdmin{
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
	BOOL flag = YES;
    
	for (Admin *admin in self.List) {
		if (admin.username == self.username.text) {
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
			flag = NO;
		}
	}
	if (flag == YES && self.name.text != nil) {
		AdminModel *adminModel = [[DataManager sharedDataManager] createNewAdminModelWithName:self.name.text birthDay:self.birthday.text email:self.email.text mobile:self.mobile.text address:self.address.text userName:self.userName.text password:self.password.text imagePath:imagePath];
		NSLog(@"Saved");
		[adminModel managedObject];
	}
    
	[self.navigationController popViewControllerAnimated:YES];
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
