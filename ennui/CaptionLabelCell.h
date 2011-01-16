//
//  CaptionLabelCell.h
//  ennui
//
//  Created by Aubrey Goodman on 2/15/10.
//  Copyright 2010 Migrant Studios LLC. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CaptionLabelCell : UITableViewCell {

	IBOutlet UILabel* caption;
	IBOutlet UILabel* label;
	
}

@property (retain) UILabel* caption;
@property (retain) UILabel* label;


@end
