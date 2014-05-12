//
//  LoginViewController.m
//  StudentManager
//
//  Created by Nguyễn Nam Phong on 5/5/14.
//  Copyright (c) 2014 RoxWin. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "Admin.h"
#import "Student.h"
#import "Teacher.h"
@interface LoginViewController ()

@property (nonatomic, strong) NSMutableArray *adminList;
@property (nonatomic, strong) NSMutableArray *teacherList;
@property (nonatomic, strong) NSMutableArray *studentList;

@property (nonatomic) BOOL isAdmin;
@property (nonatomic) BOOL isTeacher;
@property (nonatomic) BOOL isStudent;
@property (nonatomic, strong) AppDelegate *appDelegate;

@end

@implementation LoginViewController

- (void)initial
{
    self.isAdmin = NO;
    self.isTeacher = NO;
    self.isStudent = NO;
	UIColor *mainColor = [UIColor colorWithRed:28.0 / 255 green:158.0 / 255 blue:121.0 / 255 alpha:1.0f];
	self.view.backgroundColor = mainColor;
    self.loginButton.layer.cornerRadius = 5.0f;
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initial];
    [self checkUserDefault];
}

- (BOOL)checkUserNameAndPass2
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    Student *student = [Student MR_findFirstByAttribute:@"username" withValue:[defaults stringForKey:@"username"]];
    if (student != nil) {
        if ([student.password isEqual:[defaults stringForKey:@"password"]]) {
            self.appDelegate.username = student.username;
            self.appDelegate.password = student.password;
            self.appDelegate.isStudent = YES;
            return YES;
        }
    }
    
    Teacher *teacher = [Teacher MR_findFirstByAttribute:@"username" withValue:[defaults stringForKey:@"username"]];
    if (teacher != nil) {
        if ([teacher.password isEqual:[defaults stringForKey:@"password"]]) {
            self.appDelegate.username = teacher.username;
            self.appDelegate.password = teacher.password;
            self.appDelegate.isTeacher = YES;
            return YES;
        }
    }
    
    Admin *admin = [Admin MR_findFirstByAttribute:@"username" withValue:[defaults stringForKey:@"username"]];
    if (admin != nil) {
        if ([admin.password isEqual:[defaults stringForKey:@"password"]]) {
            self.appDelegate.username = admin.username;
            self.appDelegate.password = admin.password;
            self.appDelegate.isAdmin = YES;
            return YES;
        }
    }
    
    if ([[defaults stringForKey:@"username"] isEqualToString:@"admin"] && [[defaults stringForKey:@"password"] isEqualToString:@"admin"]) {
        self.appDelegate.username = @"admin";
        self.appDelegate.password = @"admin";
        self.appDelegate.isAdmin = YES;
        return YES;
    }
    return NO;
}

- (BOOL)checkUserNameAndPass
{
    Student *student = [Student MR_findFirstByAttribute:@"username" withValue:self.userNameTextField.text];
    if (student != nil) {
        if ([student.password isEqual:self.passwordTextField.text]) {
            self.appDelegate.username = student.username;
            self.appDelegate.password = student.password;
            self.appDelegate.isStudent = YES;
            return YES;
        }
    }
    
    Teacher *teacher = [Teacher MR_findFirstByAttribute:@"username" withValue:self.userNameTextField.text];
    if (teacher != nil) {
        if ([teacher.password isEqual:self.passwordTextField.text]) {
            self.appDelegate.username = teacher.username;
            self.appDelegate.password = teacher.password;
            self.appDelegate.isTeacher = YES;
            return YES;
        }
    }
    
    Admin *admin = [Admin MR_findFirstByAttribute:@"username" withValue:self.userNameTextField.text];
    if (admin != nil) {
        if ([admin.password isEqual:self.passwordTextField.text]) {
            self.appDelegate.username = admin.username;
            self.appDelegate.password = admin.password;
            self.appDelegate.isAdmin = YES;
            return YES;
        }
    }
    
    if ([self.userNameTextField.text isEqualToString:@"admin"] && [self.passwordTextField.text isEqualToString:@"admin"]) {
        self.appDelegate.username = @"admin";
        self.appDelegate.password = @"admin";
        self.appDelegate.isAdmin = YES;
        return YES;
    }
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)login:(id)sender {
    if ([self checkUserNameAndPass]) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:self.userNameTextField.text forKey:@"username"];
        [defaults setObject:self.passwordTextField.text forKey:@"password"];
        [defaults synchronize];
        if (self.appDelegate.isAdmin) {
            [[Util sharedUtil]showMessage:@"Welcome Admin." withTitle:@"Login Successful!"];
            [self presentViewController];
        } else if (self.appDelegate.isTeacher) {
            [[Util sharedUtil]showMessage:@"Welcome Teacher. Teach well - Study well" withTitle:@"Login Successful!"];
            [self presentViewController];
        } else{
            [[Util sharedUtil]showMessage:@"Welcome Student. Study well - Teach Well" withTitle:@"Login Successful!"];
            [self presentViewController];
        }
        
    }else{
        [[Util sharedUtil]showMessage:@"Username or password is incorrect" withTitle:@"Login failed!"];
    }
}

-(void)checkUserDefault{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@", [[NSUserDefaults standardUserDefaults] dictionaryRepresentation]);
    // check if user is already Login
    if([defaults objectForKey:@"username"]!=nil  && [defaults objectForKey:@"password"]){
        if ([self checkUserNameAndPass2]) {
            if (self.appDelegate.isAdmin) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Welcome!" message:@"Do you want return back to the last session?" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
                alert.alertViewStyle = UIAlertViewStyleDefault;
                [alert show];
            } else if (self.appDelegate.isTeacher) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Welcome!" message:@"Do you want return back to the last session?" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
                alert.alertViewStyle = UIAlertViewStyleDefault;
                [alert show];
            } else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Welcome!" message:@"Do you want return back to the last session?" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
                alert.alertViewStyle = UIAlertViewStyleDefault;
                [alert show];
            }
            
        }
        self.userNameTextField.text = [defaults stringForKey:@"username"];
        self.passwordTextField.text = [defaults stringForKey:@"password"];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 1) {
		NSLog(@"cancel");
	}
	else {
		[self presentViewController];
	}
}

- (void)presentViewController{
    UIStoryboard *nextStoryboard = [UIStoryboard storyboardWithName:@"MenuView" bundle:nil];
    UINavigationController *navController = [nextStoryboard instantiateInitialViewController];
    self.view.window.rootViewController = navController;
    [Session sharedInstance].isAuthen = YES;
}

@end
