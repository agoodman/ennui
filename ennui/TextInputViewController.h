//
//  TextInputViewController.h
//  Rakiteer
//
//  Created by Aubrey Goodman on 8/27/12.
//  Copyright (c) 2012 Migrant Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AutocompleteDataSource.h"


typedef void(^TextInputBlock)(NSString*,NSString*);

@interface TextInputViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

@property (strong) IBOutlet UISearchBar* searchBar;
@property (strong) IBOutlet UITableView* tableView;
@property (strong) NSString* keyPath;
@property (strong) NSString* value;
@property (copy) dispatch_block_t cancelBlock;
@property (copy) TextInputBlock saveBlock;
@property (strong) id<AutocompleteDataSource> autocompleteDataSource;
@property (strong) NSDictionary* autocompleteConditions;

@end
