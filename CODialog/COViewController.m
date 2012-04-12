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
  dialog.subtitle = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec at tincidunt arcu. Donec faucibus velit ac ante condimentum pulvinar. Aliquam eget urna vel tortor laoreet porttitor. Pellentesque molestie fringilla tortor, ut consectetur diam adipiscing sit amet.";
  
  [dialog addButtonWithTitle:@"Cancel" target:self selector:@selector(cancel:)];
  [dialog addButtonWithTitle:@"Upload" target:self selector:@selector(upload:) highlighted:YES];
  [dialog showOrUpdateAnimated:YES];
}

- (void)cancel:(id)sender {
  NSLog(@"cancel");
}

- (void)upload:(id)sender {
  NSLog(@"upload");
}

@end
