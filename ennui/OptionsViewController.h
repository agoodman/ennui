//
//  OptionsViewController.h
//  Rakiteer
//
//  Created by Aubrey Goodman on 8/27/12.
//  Copyright (c) 2012 Migrant Studios. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^OptionsBlock)(NSString*,id);

@interface OptionsViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (strong) IBOutlet UITableView* tableView;
@property (strong) NSString* keyPath;
@property (strong) NSArray* options;
@property (strong) id selectedValue;
@property (copy) dispatch_block_t cancelBlock;
@property (copy) OptionsBlock saveBlock;

@end
