//
//  NavigationController.m
//  StudentManager
//
//  Created by Nguyễn Nam Phong on 4/24/14.
//  Copyright (c) 2014 Phongnn. All rights reserved.
//

#import "NavigationController.h"

@interface NavigationController ()

@end

@implementation NavigationController


- (void)viewDidLoad {
	[super viewDidLoad];
	[self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)]];
}

- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender {
	// Dismiss keyboard (optional)
	//
	[self.view endEditing:YES];
	[self.frostedViewController.view endEditing:YES];

	// Present the view controller
	//
	[self.frostedViewController panGestureRecognized:sender];
}

@end
