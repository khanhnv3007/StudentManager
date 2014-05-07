//
//  CreateClass.m
//  StudentManager
//
//  Created by Nguyễn Nam Phong on 5/7/14.
//  Copyright (c) 2014 RoxWin. All rights reserved.
//

#import "CreateClass.h"
#import "Subject.h"

@interface CreateClass ()

@end

@implementation CreateClass

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)createClass:(id)sender {
    Subject *class = [Subject MR_createEntity];
    class.name = self.name.text;
    class.subjectID = [[Util sharedUtil] generateGUID];
    
    [[Util sharedUtil] showMessage:@"Your class has been created!" withTitle:@"Create Success"];
}
@end