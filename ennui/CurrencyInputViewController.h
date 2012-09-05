//
//  CurrencyInputViewController.h
//  Rakiteer
//
//  Created by Aubrey Goodman on 8/27/12.
//  Copyright (c) 2012 Migrant Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CurrencyInputBlock)(NSString*,NSString*);

@interface CurrencyInputViewController : UIViewController

@property (strong) IBOutlet UITextField* textInput;
@property (strong) IBOutlet UILabel* textDisplay;
@property (strong) NSString* keyPath;
@property (strong) NSString* value;
@property (copy) dispatch_block_t cancelBlock;
@property (copy) CurrencyInputBlock saveBlock;

@end
