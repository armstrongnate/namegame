//
//  NGGroupOperation.m
//  NameGame
//
//  Created by Nate Armstrong on 8/12/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

#import "NGGroupOperation.h"

@interface NGGroupOperation ()

@property (nonatomic, strong) NSOperationQueue *internalQueue;

@end

@implementation NGGroupOperation

- (NSOperationQueue *)internalQueue
{
	if (!_internalQueue)
	{
		_internalQueue = [NSOperationQueue new];
	}

	return _internalQueue;
}

- (instancetype)initWithOperations:(NSArray *)operations
{
	if (!(self = [super init])) return nil;

	[operations enumerateObjectsUsingBlock:^(NSOperation *operation, NSUInteger idx, BOOL *stop) {
		[self addOperation:operation];
	}];

	return self;
}

- (void)addOperation:(NSOperation *)operation
{
	[self.internalQueue addOperation:operation];
}

@end
