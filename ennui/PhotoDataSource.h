//
//  PhotoDataSource.h
//  Rakiteer
//
//  Created by Aubrey Goodman on 8/30/12.
//  Copyright (c) 2012 Migrant Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PhotoDataSource <NSObject>

-(void)loadImageNamed:(NSString*)aPath successBlock:(void(^)(UIImage*,BOOL))aSuccessBlock failureBlock:(void(^)(BOOL))aFailureBlock;

@end
