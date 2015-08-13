//
//  NGOperation.m
//  NameGame
//
//  Created by Nate Armstrong on 8/12/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

#import "NGOperation.h"

@interface NGOperation ()

@property (nonatomic) BOOL stateExecuting;
@property (nonatomic) BOOL stateFinished;

@end

@implementation NGOperation

#pragma mark - NSOperation Overrides

- (BOOL)isAsynchronous
{
	return YES;
}

- (BOOL)isExecuting
{
	return self.stateExecuting;
}

- (BOOL)isFinished
{
	return self.stateFinished;
}

- (void)start
{
	[self willChangeValueForKey:@"isExecuting"];
	self.stateExecuting = YES;
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
	self.stateFinished = YES;
	[self didChangeValueForKey:@"isFinished"];
}

@end
