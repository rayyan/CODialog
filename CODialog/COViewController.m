//
//  COViewController.m
//  CODialog
//
//  Created by Erik Aigner on 12.04.12.
//  Copyright (c) 2012 chocomoko.com. All rights reserved.
//

#import "COViewController.h"

#import "CODialog.h"


@implementation COViewController

- (void)viewDidAppear:(BOOL)animated {
  UIImage *image = [UIImage imageNamed:@"wallpaper.jpg"];
  UIColor *color = [UIColor colorWithPatternImage:image];
  
  self.view.backgroundColor = color;
  
  // Display dialog
  CODialog *dialog = [CODialog dialogWithView:self.view];
  dialog.title = @"Title";
  dialog.subtitle = @"Subtitle";
  
  [dialog addButtonWithTitle:@"Cancel" target:self selector:@selector(cancel:)];
  [dialog addButtonWithTitle:@"Upload" target:self selector:@selector(upload:)];
  [dialog showOrUpdateAnimated:YES];
}

- (void)cancel:(id)sender {
  NSLog(@"cancel");
}

- (void)upload:(id)sender {
  NSLog(@"upload");
}

@end
