//
//  EditorViewController.h
//  Rakiteer
//
//  Created by Aubrey Goodman on 8/27/12.
//  Copyright (c) 2012 Migrant Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AutocompleteDataSource.h"
#import "PhotoDataSource.h"
#import "PhotoDelegate.h"


typedef void(^EditorBlock)(NSDictionary*);

@interface EditorViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (strong) IBOutlet UITableView* tableView;
@property (strong) NSDictionary* config;
@property (strong) NSArray* keys;
@property (strong) NSDictionary* fields;
@property (copy) dispatch_block_t cancelBlock;
@property (copy) EditorBlock saveBlock;
@property (strong) id<AutocompleteDataSource> autocompleteDataSource;
@property (strong) id<PhotoDataSource> photoDataSource;
@property (strong) id<PhotoDelegate> photoDelegate;

@end
