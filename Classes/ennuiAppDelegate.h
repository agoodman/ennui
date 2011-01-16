//
//  ennuiAppDelegate.h
//  ennui
//
//  Created by Aubrey Goodman on 1/16/11.
//  Copyright 2011 Migrant Studios LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ennuiAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

