//
//  Util.m
//  StudentManager
//
//  Created by Nguyễn Nam Phong on 4/21/14.
//  Copyright (c) 2014 Phongnn. All rights reserved.
//

#import "Util.h"

@implementation Util


+ (Util *)sharedUtil
{
    DEFINE_SHARED_INSTANCE_USING_BLOCK(^{
        return [[self alloc] init];
    });
    
}

#pragma mark Alert functions
- (void)showMessage:(NSString *)message withTitle:(NSString *)title {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

- (void)showMessage:(NSString *)message withTitle:(NSString *)title andDelegate:(id)delegate
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [alert show];
}

- (void)showMessage:(NSString *)message withTitle:(NSString *)title delegate:(id)delegate andTag:(NSInteger)tag
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    alert.tag = tag;
    [alert show];
}

- (void)showMessage:(NSString *)message withTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelTitle otherButtonTitles:(NSString *)otherTitle delegate:(id)delegate andTag:(NSInteger)tag
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelTitle otherButtonTitles:otherTitle, nil];
    alert.tag = tag;
    alert.delegate = delegate;
    [alert show];
}

- (NSString *)generateGUID{
    CFUUIDRef __uuid = CFUUIDCreate(nil);
    NSString *__guid = (NSString *) CFBridgingRelease(CFUUIDCreateString(nil, __uuid));
    
    CFRelease(__uuid);
    
    return __guid;
}

-(NSDate *)getDateFromString:(NSString *)pstrDate
{
    DLog(@"date: %@",pstrDate);
    NSDateFormatter *df1 = [[NSDateFormatter alloc] init];
    [df1 setDateFormat:@"yyyy-MM-dd"];
    NSDate *dtPostDate = [[NSDate alloc]init];
    dtPostDate = [df1 dateFromString:pstrDate];
    return dtPostDate;
    
}

- (NSString *)getStringFromDate:(NSDate *)date
{
    // Create a NSDateFormatter object to handle the date.
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // Otherwise keep just the date.
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    
    // Return the formatted date as a string value.
    return [formatter stringFromDate:date];
}

@end
