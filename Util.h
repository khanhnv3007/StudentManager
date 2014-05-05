//
//  Util.h
//  StudentManager
//
//  Created by Nguyễn Nam Phong on 4/21/14.
//  Copyright (c) 2014 Phongnn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Util : NSObject
+ (Util *)sharedUtil;
- (NSString *)generateGUID;
- (NSDate *)getDateFromString:(NSString *)pstrDate;
- (NSString *)getStringFromDate:(NSDate *)date;
- (void)showMessage:(NSString *)message withTitle:(NSString *)title;
- (void)showMessage:(NSString *)message withTitle:(NSString *)title andDelegate:(id)delegate;
- (void)showMessage:(NSString *)message withTitle:(NSString *)title delegate:(id)delegate andTag:(NSInteger)tag;
- (void)showMessage:(NSString *)message withTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelTitle otherButtonTitles:(NSString *)otherTitle delegate:(id)delegate andTag:(NSInteger)tag;

@end
