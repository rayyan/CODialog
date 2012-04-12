//
//  CODialog.h
//  CODialog
//
//  Created by Erik Aigner on 10.04.12.
//  Copyright (c) 2012 chocomoko.com. All rights reserved.
//

#import <UIKit/UIKit.h>


enum {
  CODialogStyleIndeterminate,
  CODialogStyleDeterminate,
  CODialogStyleTextInput,
  CODialogStyleSuccess,
  CODialogStyleError,
  CODialogStyleCustomView
};
typedef NSInteger CODialogStyle;

@interface CODialog : UIView
@property (nonatomic, strong) UIView *customView;
@property (nonatomic, assign) CODialogStyle dialogStyle;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, assign) NSTimeInterval batchDelay;

+ (instancetype)dialogWithView:(UIView *)hostView;

- (id)initWithView:(UIView *)hostView;

- (void)showOrUpdateAnimated:(BOOL)flag;
- (void)hideAnimated:(BOOL)flag;
- (void)hideAnimated:(BOOL)flag afterDelay:(NSTimeInterval)delay;

/** @name Methods to Override */

- (void)drawDialogBackgroundInRect:(CGRect)rect;
- (void)drawButtonInRect:(CGRect)rect highlighted:(BOOL)highlighted down:(BOOL)down;

@end
