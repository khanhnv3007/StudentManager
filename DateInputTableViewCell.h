//
//  DateInputTableViewCell.h
//  StudentManager
//
//  Created by Nguyễn Nam Phong on 5/12/14.
//  Copyright (c) 2014 RoxWin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DateInputTableViewCell;
@protocol DateInputTableViewCellDelegate <NSObject>
@optional
- (void)tableViewCell:(DateInputTableViewCell *)cell didEndEditingWithDate:(NSDate *)value;
- (void)tableViewCell:(DateInputTableViewCell *)cell didEndEditingWithDuration:(NSTimeInterval)value;
@end

@interface DateInputTableViewCell : UITableViewCell <UIPopoverControllerDelegate> {
	UIPopoverController *popoverController;
	UIToolbar *inputAccessoryView;
}

@property (nonatomic, strong) NSDate *dateValue;
@property (nonatomic, assign) NSTimeInterval timerValue;
@property (nonatomic, assign) UIDatePickerMode datePickerMode;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (weak) IBOutlet id<DateInputTableViewCellDelegate> delegate;

- (void)setMaxDate:(NSDate *)max;
- (void)setMinDate:(NSDate *)min;
- (void)setMinuteInterval:(NSUInteger)value;
- (NSString *)timerStringValue;

@end
