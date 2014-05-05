//
//  PPConstants.m
//  PPFoundation
//
//  Created by Hieu Bui on 3/5/14.
//  Copyright (c) 2014 PIPU, Inc. All rights reserved.
//

#import "PPConstants.h"
NSString *const kAPIBaseURLString                           = @"http://res.localhost/";

NSString * const kPathGetTablesList                         = @"categories/listtableapi";
NSString * const kPathSubmitFoodsTable                      = @"categories/submitfoodtableapi";
NSString * const kPathGetUpdateCategories                   = @"categories/getallfoodcategoryapi";
NSString * const kPathGetListAllCategoriesAndFoods          = @"categories/getfoodlistapi";
NSString * const kPathMarkATableAsFree                      = @"categories/marktablefreeapi";
NSString * const kPathAllFoodCategories                     = @"/getAllDish";

NSString * const kParamsCategoryID                          = @"category_id";
NSString * const kParamsTableID                             = @"table_id";
NSString * const kParamsFoodID                              = @"food_id";
NSString * const kParamsListFoodID                          = @"foods_list";
NSString * const kParamsModifyDate                          = @"modify_date";