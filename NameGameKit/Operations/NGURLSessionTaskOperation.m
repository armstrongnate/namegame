//
//  NGURLSessionTaskOperation.m
//  NameGame
//
//  Created by Nate Armstrong on 8/12/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

#import "NGURLSessionTaskOperation.h"

@interface NGURLSessionTaskOperation ()

@property (nonatomic, strong) NSURLSessionTask *task;

@end

@implementation NGURLSessionTaskOperation

- (instancetype)initWithTask:(NSURLSessionTask *)task
{
	if (!(self = [super init])) return nil;

	NSAssert(task.state == NSURLSessionTaskStateSuspended, @"task must be suspended");
	self.task = task;

	return self;
}

- (void)execute
{
	NSAssert(self.task.state == NSURLSessionTaskStateSuspended, @"task must be suspended");

	[self.task addObserver:self forKeyPath:@"state" options:0 context:nil];
	[self.task resume];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if (object == self.task && [keyPath isEqualToString:@"state"] && self.task.state == NSURLSessionTaskStateCompleted)
	{
		[self.task removeObserver:self forKeyPath:@"state"];
		[self finish];
	}
}

@end
