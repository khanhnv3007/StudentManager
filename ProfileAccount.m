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
    self.password.text = self.getPassword;
    self.username.text = self.getUsername;
}

- (IBAction)showMenu:(id)sender {

    
}

- (IBAction)Update:(id)sender{
    
}

@end
