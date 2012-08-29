//
//  AutocompleteDataSource.h
//  Rakiteer
//
//  Created by Aubrey Goodman on 8/28/12.
//  Copyright (c) 2012 Migrant Studios. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^AutocompleteBlock)(NSArray*);

@protocol AutocompleteDataSource <NSObject>

-(void)optionsForObject:(NSString*)aObject field:(NSString*)aField startsWith:(NSString*)aSeed conditions:(NSDictionary*)aConditions callback:(AutocompleteBlock)aCallback;
-(NSString*)objectForKeyPath:(NSString*)aKeyPath;
-(NSString*)fieldForKeyPath:(NSString*)aKeyPath;

@end
