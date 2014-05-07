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

@end

@implementation ProfileAccount

- (void)init_user
{
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.isAdmin = self.appDelegate.isAdmin;
    self.isStudent = self.appDelegate.isStudent;
    self.isTeacher = self.appDelegate.isTeacher;
    
    self.getPassword = self.appDelegate.password;
    self.getUsername = self.appDelegate.username;
    
    self.admin = [Admin MR_findFirstByAttribute:@"username" withValue:self.getUsername];
    self.teacher = [Teacher MR_findFirstByAttribute:@"username" withValue:self.getUsername];
    self.student = [Student MR_findFirstByAttribute:@"username" withValue:self.getUsername];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self init_user];
    [self showProfile];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (void)showProfile
{
    if (self.isAdmin) {
        self.name.text = self.admin.name;
        self.address.text = self.admin.address;
        self.phoneNumber.text = self.admin.phoneNumber;
        self.email.text = self.admin.email;
        self.username.text = self.admin.username;
        self.password.text = self.admin.password;
        self.avatar.image = [UIImage imageWithContentsOfFile:self.admin.avatar];
    }
}

- (IBAction)showMenu:(id)sender {

    
}

- (IBAction)Update:(id)sender{
    
}

@end
