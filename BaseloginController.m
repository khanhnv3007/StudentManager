//
//  BaseloginController.m
//  StudentManager
//
//  Created by Nguyễn Nam Phong on 4/22/14.
//  Copyright (c) 2014 Phongnn. All rights reserved.
//

#import "BaseloginController.h"

@interface BaseloginController ()

@end

@implementation BaseloginController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

#pragma setup view when it is hided by keyboard

- (void)keyboardWillShow {
	if (self.view.frame.origin.y >= 0) {
		[self setViewMoveUp:YES];
	}
	else {
		[self setViewMoveUp:NO];
	}
}

- (void)keyboardWillHide {
	if (self.view.frame.origin.y >= 0) {
		[self setViewMoveUp:YES];
	}
	else {
		[self setViewMoveUp:NO];
	}
}

- (void)textFieldDidBeginEditing:(UITextField *)sender {
	if (self.view.frame.origin.y >= 0) {
		[self setViewMoveUp:YES];
	}
}

- (void)setViewMoveUp:(BOOL)movedUp {
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3];

	CGRect rect = self.view.frame;
	if (movedUp) {
		rect.origin.y -= kOFFSET_FOR_KEYBOARD;
		rect.size.height += kOFFSET_FOR_KEYBOARD;
	}
	else {
		rect.origin.y += kOFFSET_FOR_KEYBOARD;
		rect.size.height -= kOFFSET_FOR_KEYBOARD;
	}
	self.view.frame = rect;

	[UIView commitAnimations];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[self.view endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated {
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow) name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide) name:UIKeyboardWillHideNotification object:nil];

	[self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

@end
