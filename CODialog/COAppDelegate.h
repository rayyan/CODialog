//
//  COAppDelegate.h
//  CODialog
//
//  Created by Erik Aigner on 12.04.12.
//  Copyright (c) 2012 chocomoko.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class COViewController;

@interface COAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) COViewController *viewController;

@end
