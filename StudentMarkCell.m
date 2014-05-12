//
//  StudentMarkCell.m
//  StudentManager
//
//  Created by Nguyễn Nam Phong on 5/7/14.
//  Copyright (c) 2014 RoxWin. All rights reserved.
//

#import "StudentMarkCell.h"
#import "Subject.h"
#import "Mark.h"

@implementation StudentMarkCell

- (void)awakeFromNib
{
    self.avatar.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
