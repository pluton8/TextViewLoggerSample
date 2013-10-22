//
//  UITextViewLogger.h
//
//  Created by Eugene Nikolsky on 8/8/12.
//  Copyright (c) 2012–2013. All rights reserved.
//

#import "DDLog.h"

/*
 * A logger for CocoaLumberjack that outputs the messages to
 * a UITextView.
 * 
 * If textView is not set up, the logs will be cached and then
 * flushed when it's set up.
 */
@interface UITextViewLogger : DDAbstractLogger <DDLogger>

// Text view where to print logs to.
@property (nonatomic, weak) UITextView *textView;
// Specifies if the text view should be automatically scrolled
// to bottom after appending any log message.
@property (nonatomic, assign) BOOL autoScrollsToBottom;

@end
