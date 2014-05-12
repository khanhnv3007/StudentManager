//
//  DateInputTableViewCell.m
//  StudentManager
//
//  Created by Nguyễn Nam Phong on 5/12/14.
//  Copyright (c) 2014 RoxWin. All rights reserved.
//

#import "DateInputTableViewCell.h"

@implementation DateInputTableViewCell

@synthesize delegate;
@synthesize dateValue;
@synthesize dateFormatter;
@synthesize datePicker;
@synthesize timerValue = _timerValue;

- (void)initalizeInputView {
	dateValue = [NSDate date];
	self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
	[datePicker setDatePickerMode:UIDatePickerModeDate];
	datePicker.date = self.dateValue;
	[datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];

		CGRect frame = self.inputView.frame;
		frame.size = [self.datePicker sizeThatFits:CGSizeZero];
		self.inputView.frame = frame;
		self.datePicker.autoresizingMask = UIViewAutoresizingFlexibleHeight;

	self.dateFormatter = [[NSDateFormatter alloc] init];
	self.dateFormatter.timeStyle = NSDateFormatterNoStyle;
	self.dateFormatter.dateStyle = NSDateFormatterMediumStyle;

        self.detailTextLabel.text = [self.dateFormatter stringFromDate:self.dateValue];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initalizeInputView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initalizeInputView];
    }
    return self;
}

- (UIView *)inputView {
		return self.datePicker;
}

- (UIView *)inputAccessoryView {
		if (!inputAccessoryView) {
			inputAccessoryView = [[UIToolbar alloc] init];
			inputAccessoryView.barStyle = UIBarStyleBlackTranslucent;
			inputAccessoryView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
			[inputAccessoryView sizeToFit];
			CGRect frame = inputAccessoryView.frame;
			frame.size.height = 44.0f;
			inputAccessoryView.frame = frame;
			
			UIBarButtonItem *doneBtn =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
			UIBarButtonItem *flexibleSpaceLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
			
			NSArray *array = [NSArray arrayWithObjects:flexibleSpaceLeft, doneBtn, nil];
			[inputAccessoryView setItems:array];
		}
		return inputAccessoryView;
}

- (void)done:(id)sender {
	[self resignFirstResponder];
}

- (BOOL)becomeFirstResponder {
        self.datePicker.date = self.dateValue;
    
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder {

    UITableView *tableView;
    if ([self.superview class] != [UITableView class])
    {
        tableView = (UITableView *)self.superview.superview;
    }
    else
    {
        tableView = (UITableView *)self.superview;
    }
	[tableView deselectRowAtIndexPath:[tableView indexPathForCell:self] animated:YES];
	return [super resignFirstResponder];
}

- (void)prepareForReuse {
	self.dateFormatter.timeStyle = NSDateFormatterNoStyle;
	self.dateFormatter.dateStyle = NSDateFormatterMediumStyle;
	self.datePicker.datePickerMode = UIDatePickerModeDate;
	self.datePicker.maximumDate = nil;
	self.datePicker.minimumDate = nil;
}

- (void)setDateValue:(NSDate *)value {
	dateValue = value;
    NSString *text = [NSString stringWithFormat:@"%@", [self.dateFormatter stringFromDate:self.dateValue]];
    self.detailTextLabel.text = text;;
}

- (void)setDatePickerMode:(UIDatePickerMode)mode {
	self.datePicker.datePickerMode = mode;
	self.dateFormatter.dateStyle = NSDateFormatterMediumStyle;
	self.dateFormatter.timeStyle = NSDateFormatterShortStyle;
        self.dateValue = [NSDate date];
        self.timerValue = 0;
        self.detailTextLabel.text = [self.dateFormatter stringFromDate:self.dateValue];
}

- (UIDatePickerMode)datePickerMode {
	return self.datePicker.datePickerMode;
}

- (void)setMaxDate:(NSDate *)max {
	self.datePicker.maximumDate = max;
}

- (void)setMinDate:(NSDate *)min {
	self.datePicker.minimumDate = min;
}

- (void)setMinuteInterval:(NSUInteger)value {
#pragma warning "Check with Apple why this causes a crash"
	//	[self.datePicker setMinuteInterval:value];
}

- (void)dateChanged:(id)sender {
	self.dateValue = ((UIDatePicker *)sender).date;
    self.timerValue = ((UIDatePicker *)sender).countDownDuration;
    
	if (delegate && self.dateValue) {
        if (self.datePicker.datePickerMode == UIDatePickerModeDate && [delegate respondsToSelector:@selector(tableViewCell:didEndEditingWithDuration:)]) {
            [delegate tableViewCell:self didEndEditingWithDuration:self.timerValue];
        } else if ([delegate respondsToSelector:@selector(tableViewCell:didEndEditingWithDate:)]) {
            [delegate tableViewCell:self didEndEditingWithDate:self.dateValue];
        }
	}
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
	if (selected) {
		[self becomeFirstResponder];
	}
}

- (NSTimeInterval)timerValue {
    return self.datePicker.countDownDuration;
}

- (void)setTimerValue:(NSTimeInterval)timerValue {
    if (self.datePicker.datePickerMode == UIDatePickerModeCountDownTimer) {
		datePicker.countDownDuration = timerValue;
		_timerValue = timerValue;
        
        self.detailTextLabel.text = [self timerStringValue];
    } else {
        // self.detailTextLabel.text = [self.dateFormatter stringFromDate:self.dateValue];
    }
}

- (NSString *)timerStringValue {
    NSTimeInterval time = self.timerValue;
    NSString *result = nil;
    
    if (time >= 3600.0) {
        result = [NSString stringWithFormat:@"%uhr, %umin ", (int)(time / 3600.0), (int)((time / 60.0) - (floor(time / 3600.0) * 60.0))];
    } else if (time >= 60.0) {
        result = [NSString stringWithFormat:@"%umin       ", (int)(time / 60.0)];
    } else {
        result = [NSString stringWithFormat:@"%usec       ", (int)time];
    } // The padding at the end makes it impossible for the detail label to trim the text
    
    // NSLog(@"%@", result);
    return result;
}

@end
