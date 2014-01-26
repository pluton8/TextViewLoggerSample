//
//  UITextViewLogger.m
//
//  Created by Eugene Nikolsky on 8/8/12.
//  Copyright (c) 2012–2013. All rights reserved.
//

#import "UITextViewLogger.h"

@interface UITextViewLogger ()

@property (nonatomic, strong) NSMutableArray *logMsgCache;

@end


@implementation UITextViewLogger

@synthesize textView = _textView;
@synthesize autoScrollsToBottom = _autoScrollsToBottom;
@synthesize logMsgCache = _logMsgCache;

#pragma mark - Init

- (id)init {
	if (self = [super init]) {
		_autoScrollsToBottom = YES;
	}
	return self;
}

#pragma mark - Private Stuff

- (void)appendTextViewString:(NSString *)string {
	NSAssert(self.textView != nil, @"self.textView is nil");
	
	dispatch_async(dispatch_get_main_queue(), ^(void) {
		NSString *newText = [self.textView.text stringByAppendingString:string];
		self.textView.text = newText;
		
		if (self.autoScrollsToBottom) {
			[self.textView scrollRangeToVisible:NSMakeRange(newText.length, 0)];
		}
	});
}

#pragma mark - DDLogger

- (void)logMessage:(DDLogMessage *)logMessage {
	NSString *logMsg = logMessage->logMsg;
	if (formatter) {
		logMsg = [formatter formatLogMessage:logMessage];
	}
	
	if (logMsg) {
		/* if textView is available, write to it,
		 otherwise cache it */
		if (self.textView) {
			[self appendTextViewString:[NSString stringWithFormat:@"\n%@", logMsg]];
		} else {
			if (!self.logMsgCache) {
				self.logMsgCache = [NSMutableArray array];
			}
			
			[self.logMsgCache addObject:logMsg];
		}
	}
}

#pragma mark - Getters & Setters

- (void)setTextView:(UITextView *)textView {
	if (_textView != textView) {
		_textView = textView;
		
		NSString *entireLog = [self.logMsgCache componentsJoinedByString:@"\n"];
		[self.logMsgCache removeAllObjects];
		
		[self appendTextViewString:entireLog];
	}
}

@end
