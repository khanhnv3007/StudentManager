//
//  RootView.m
//  StudentManager
//
//  Created by Nguyễn Nam Phong on 4/24/14.
//  Copyright (c) 2014 Phongnn. All rights reserved.
//

#import "RootView.h"

@interface RootView ()

@end

@implementation RootView


- (void)awakeFromNib {
	self.contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"navController"];
	self.menuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"menuController"];
}

@end
