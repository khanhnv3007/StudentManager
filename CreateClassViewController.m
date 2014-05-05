//
//  CreateClassViewController.m
//  StudentManager
//
//  Created by Nguyễn Nam Phong on 5/5/14.
//  Copyright (c) 2014 RoxWin. All rights reserved.
//

#import "CreateClassViewController.h"
#import "DataManager.h"
#import "SubjectModel.h"

@interface CreateClassViewController ()

@end

@implementation CreateClassViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createClass:(id)sender {
    SubjectModel *subjectModel = [[DataManager sharedDataManager] createClassWithSubject:self.subject.text AndTeacher:self.teacher.text];
    [subjectModel managedObject];
}
@end
