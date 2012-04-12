//
//  COViewController.m
//  CODialog
//
//  Created by Erik Aigner on 12.04.12.
//  Copyright (c) 2012 chocomoko.com. All rights reserved.
//

#import "COViewController.h"

#import "CODialog.h"


@interface COViewController ()
@property (nonatomic, strong) CODialog *dialog;
@end

@implementation COViewController
@synthesize dialog;

- (void)viewDidAppear:(BOOL)animated {
  UIImage *image = [UIImage imageNamed:@"wallpaper.jpg"];
  UIColor *color = [UIColor colorWithPatternImage:image];
  
  self.view.backgroundColor = color;
  
  // Display dialog
  self.dialog = [CODialog dialogWithView:self.view];
  self.dialog.title = @"Title";
  self.dialog.subtitle = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec at tincidunt arcu. Donec faucibus velit ac ante condimentum pulvinar. Aliquam eget urna vel tortor laoreet porttitor. Pellentesque molestie fringilla tortor, ut consectetur diam adipiscing sit amet.";
  
  [self.dialog addButtonWithTitle:@"Do Nothing" target:self selector:@selector(doNothing:)];
  [self.dialog addButtonWithTitle:@"Next" target:self selector:@selector(showIndeterminate:) highlighted:YES];
  [self.dialog showOrUpdateAnimated:YES];
}

- (void)doNothing:(id)sender {
  NSLog(@"i'm very good at doing nothing");
}

- (void)showIndeterminate:(id)sender {
  NSLog(@"indeterminate");
  
  self.dialog.title = @"Indeterminate";
  self.dialog.subtitle = nil;
  self.dialog.dialogStyle = CODialogStyleIndeterminate;
  
  [self.dialog removeAllButtons];
  [self.dialog addButtonWithTitle:@"Do Nothing" target:self selector:@selector(doNothing:)];
  [self.dialog addButtonWithTitle:@"Next" target:self selector:@selector(showDeterminate:) highlighted:YES];
  [self.dialog showOrUpdateAnimated:YES];
}

- (void)showDeterminate:(id)sender {
  NSLog(@"determinate");
}

@end
