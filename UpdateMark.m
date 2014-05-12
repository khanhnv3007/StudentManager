//
//  UpdateMark.m
//  StudentManager
//
//  Created by Nguyễn Nam Phong on 5/12/14.
//  Copyright (c) 2014 RoxWin. All rights reserved.
//

#import "UpdateMark.h"
#import "Mark.h"

@interface UpdateMark ()

@end

@implementation UpdateMark

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self showInfor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)showInfor
{
    if (self.student.avatar == nil) {
        self.avatar.image = [UIImage imageNamed:@"no-avatar.png"];
    }
    else {
        self.avatar.image = [UIImage imageWithContentsOfFile:self.student.avatar];
        self.avatar.contentMode = UIViewContentModeScaleAspectFit;
    }
    self.name.text = self.mark.markOfStudent.name;
    self.mid.text = [self.mark.mid stringValue];
    self.final.text = [self.mark.final stringValue];
    self.average.text = [self.mark.average stringValue];
}

- (IBAction)updateMark:(id)sender {
    Mark *mark = [Mark MR_findFirstByAttribute:@"markID" withValue:self.mark.markID];
    mark.mid = [NSNumber numberWithFloat:[self.mid.text floatValue]];
    mark.final = [NSNumber numberWithFloat:[self.final.text floatValue]];
    float average = 0.4 * [self.mid.text floatValue] + 0.6 * [self.final.text floatValue];
    mark.average = [NSNumber numberWithFloat:average];
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    [[Util sharedUtil] showMessage:@"Your mark has been updated" withTitle:@"Update successfully"];
}
@end
