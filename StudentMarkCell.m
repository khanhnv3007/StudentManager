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

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
//    self.avatar.contentMode = UIViewContentModeScaleAspectFill;
//    self.avatar.clipsToBounds = YES;
//    self.avatar.layer.masksToBounds = YES;
//    self.avatar.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
//    self.avatar.layer.masksToBounds = YES;
//    self.avatar.layer.cornerRadius = 50.0;
//    self.avatar.layer.borderColor = [UIColor whiteColor].CGColor;
//    self.avatar.layer.borderWidth = 3.0f;
//    self.avatar.layer.rasterizationScale = [UIScreen mainScreen].scale;
//    self.avatar.layer.shouldRasterize = YES;
//    self.avatar.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
