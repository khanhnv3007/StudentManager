//
//  PPConstants.h
//  PPFoundation
//
//  Created by Hieu Bui on 3/5/14.
//  Copyright (c) 2014 PIPU, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark Enums
typedef enum {
    PPStatusCodeUndefined               = -1,
	PPStatusCodeSuccess                 = 200,
	PPStatusCodeCreated                 = 201,
	PPStatusCodeAccepted                = 202,
	PPStatusCodeBadRequest              = 400,
	PPStatusCodeAuthenticationFailure   = 401,
	PPStatusCodeForbidden               = 403,
	PPStatusCodeResourceNotFound        = 404,
	PPStatusCodeMethodNotAllowed        = 405,
	PPStatusCodeConflict                = 409,
	PPStatusCodePreconditionFailed      = 412,
	PPStatusCodeRequestEntityTooLarge   = 413,
	PPStatusCodeInternalServerError     = 500,
	PPStatusCodeNotImplemented          = 501,
	PPStatusCodeServiceUnavailable      = 505,
} PPStatusCode;

#pragma mark Strings
extern NSString *const kAPIBaseURLString;

#pragma - mark deffine path apiclient
extern NSString * const kPathGetTablesList;
extern NSString * const kPathSubmitFoodsTable;
extern NSString * const kPathGetUpdateCategories;
extern NSString * const kPathGetListAllCategoriesAndFoods;
extern NSString * const kPathMarkATableAsFree;

#pragma - mark deffine params apiclient

extern NSString * const kParamsCategoryID;
extern NSString * const kParamsTableID;
extern NSString * const kParamsFoodID;
extern NSString * const kParamsListFoodID;
extern NSString * const kParamsModifyDate;




