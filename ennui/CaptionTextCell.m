//
//  CaptionTextCell.m
//  ennui
//
//  Created by Aubrey Goodman on 6/28/10.
//  Copyright 2010 Migrant Studios. All rights reserved.
//

#import "CaptionTextCell.h"


@implementation CaptionTextCell

@synthesize caption, text;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        // Initialization code
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc 
{
	[caption release];
	[text release];
	[super dealloc];
}


@end
