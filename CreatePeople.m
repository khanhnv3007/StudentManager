//
//  CreatePeople.m
//  StudentManager
//
//  Created by Nguyễn Nam Phong on 5/7/14.
//  Copyright (c) 2014 RoxWin. All rights reserved.
//

#import "CreatePeople.h"
#import "Student.h"
#import "Admin.h"
#import "Teacher.h"

@interface CreatePeople ()

@end

@implementation CreatePeople

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createPeople:(id)sender {
    if (self.selectUser.selectedSegmentIndex == 0) {
        Admin *admin = [Admin MR_createEntity];
        admin.name = self.name.text;
        admin.username = self.username.text;
        admin.password = self.username.text;
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    }
    if (self.selectUser.selectedSegmentIndex == 1) {
        Teacher *teacher = [Teacher MR_createEntity];
        teacher.name = self.name.text;
        teacher.username = self.username.text;
        teacher.password = self.username.text;
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    }
    if (self.selectUser.selectedSegmentIndex == 2) {
        Student *student = [Student MR_createEntity];
        student.name = self.name.text;
        student.username = self.username.text;
        student.password = self.username.text;
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    }
}
@end
