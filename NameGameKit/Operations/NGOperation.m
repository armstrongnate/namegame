//
//  NGOperation.m
//  NameGame
//
//  Created by Nate Armstrong on 8/12/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

#import "NGOperation.h"

@interface NGOperation ()

@property (nonatomic, getter=_isExecuting) BOOL _executing;
@property (nonatomic, getter=_isFinished) BOOL _finished;

@end

@implementation NGOperation

#pragma mark - NSOperation Overrides

- (BOOL)isAsynchronous
{
	return YES;
}

- (BOOL)isExecuting
{
	return self._isExecuting;
}

- (BOOL)isFinished
{
	return self._isFinished;
}

- (void)start
{
	[self willChangeValueForKey:@"isExecuting"];
	self._executing = YES;
	[self didChangeValueForKey:@"isExecuting"];
	[self execute];
}

#pragma mark - Instance Methods

- (void)execute
{
	[NSException raise:@"Unimplemented" format:@"Subclass must implement execute"];
}

- (void)finish
{
	[self willChangeValueForKey:@"isFinished"];
	self._finished = YES;
	[self didChangeValueForKey:@"isFinished"];
}

@end
