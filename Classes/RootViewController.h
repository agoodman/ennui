//
//  RootViewController.h
//  ennui
//
//  Created by Aubrey Goodman on 1/16/11.
//  Copyright 2011 Migrant Studios LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ennui.h"


@interface RootViewController : UITableViewController <SingleLabelTextFieldDelegate,DoubleLabelTextFieldDelegate> {
	
	BOOL didPresentModal;
	
}

@end
