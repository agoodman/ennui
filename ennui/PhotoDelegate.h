//
//  PhotoDelegate.h
//  Rakiteer
//
//  Created by Aubrey Goodman on 8/30/12.
//  Copyright (c) 2012 Migrant Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PhotoDelegate <NSObject>

-(void)didSelectImage:(UIImage*)aImage forKeyPath:(NSString*)aKeyPath;

-(void)didSelectImageAtPath:(NSString*)aPath forKeyPath:(NSString*)aKeyPath;

@end
