//
//  NGGetMembersOperation.m
//  NameGame
//
//  Created by Nate Armstrong on 8/14/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

#import "NGGetMembersOperation.h"
#import "NGDownloadMembersOperation.h"
#import "NGParseMembersOperation.h"

@implementation NGGetMembersOperation

- (instancetype)initWithContext:(NSManagedObjectContext *)context completionHandler:(void (^)())completion
{
	if (!(self = [super initWithOperations:@[]])) return nil;


	NSURL *cacheFolder = [[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory
																inDomain:NSUserDomainMask
													   appropriateForURL:nil
																  create:nil
																   error:nil];
	NSURL *cacheFile = [cacheFolder URLByAppendingPathComponent:@"members.json"];

	NGDownloadMembersOperation *downloadOperation = [[NGDownloadMembersOperation alloc] initWithCacheFile:cacheFile];
	[self addOperation:downloadOperation];

	NGParseMembersOperation *parseOperation = [[NGParseMembersOperation alloc] initWithCacheFile:cacheFile context:context];
	[parseOperation addDependency:downloadOperation];
	[self addOperation:parseOperation];

	NSBlockOperation *finishOperation = [NSBlockOperation blockOperationWithBlock:^{
		[self finish];
		completion();
	}];

	[finishOperation addDependency:parseOperation];
	[self addOperation:finishOperation];

	return self;
}

@end
