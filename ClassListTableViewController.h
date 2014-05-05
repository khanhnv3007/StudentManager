//
//  ClassListTableViewController.h
//  StudentManager
//
//  Created by Nguyễn Nam Phong on 5/5/14.
//  Copyright (c) 2014 RoxWin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"

@interface ClassListTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate, SWTableViewCellDelegate>

@property (nonatomic, strong) NSMutableArray * filteredResult;

@end
