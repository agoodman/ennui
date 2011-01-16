//
//  CaptionTextCell.h
//  ennui
//
//  Created by Aubrey Goodman on 6/28/10.
//  Copyright 2010 Migrant Studios. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CaptionTextCell : UITableViewCell {

	IBOutlet UILabel* caption;
	IBOutlet UITextView* text;
	
}

@property (nonatomic, retain) UILabel* caption;
@property (nonatomic, retain) UITextView* text;

@end
