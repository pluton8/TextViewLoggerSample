//
//  ViewController.h
//  TextViewLoggerSample
//
//  Created by u on 2013-10-22.
//  Copyright (c) 2013 yes. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;
typedef void(^viewDidLoadBlock_t)(ViewController *viewController);


@interface ViewController : UIViewController

/// Text view for logging.
@property (weak, nonatomic) IBOutlet UITextView *textView;

/// The block is called when the view controller's view is loaded.
@property (copy, nonatomic) viewDidLoadBlock_t viewDidLoadBlock;

@end
