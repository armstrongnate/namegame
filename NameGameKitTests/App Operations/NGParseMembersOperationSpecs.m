//
//  NGParseMembersOperationSpecs.m
//  NameGame
//
//  Created by Nate Armstrong on 8/13/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

@import Foundation;
@import Specta;
@import Expecta;

#import "NGParseMembersOperation.h"
#import "NGPersistenceHelper.h"
#import "NGDownloadMembersOperation.h"

SpecBegin(NGParseMembersOperationSpec)

describe(@"NGParseMembersOperation", ^{

	__block NSManagedObjectContext *context;
	__block NSURL *cacheFile;
	beforeAll(^{
		context = [[[NGPersistenceHelper alloc] init] context];

		NSURL *cacheFolder = [[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:nil error:nil];
		cacheFile = [cacheFolder URLByAppendingPathComponent:@"members.json"];

		expect(context).toNot.beNil();
		expect(cacheFile).toNot.beNil();
	});

	afterEach(^{
		[context reset];
	});

	it(@"can be initialized with path and context", ^{
		NGParseMembersOperation *parseOperation = [[NGParseMembersOperation alloc] initWithCacheFile:cacheFile context:context];
		expect(parseOperation).toNot.beNil();
	});

	it(@"inserts objects into the context", ^{
		__block NGParseMembersOperation *parseOperation;
		waitUntil(^(DoneCallback done) {
			NSOperationQueue *queue = [NSOperationQueue new];
			queue.suspended = YES;

			NGDownloadMembersOperation *downloadOperation = [[NGDownloadMembersOperation alloc] initWithCacheFile:cacheFile];
			[queue addOperation:downloadOperation];

			parseOperation = [[NGParseMembersOperation alloc] initWithCacheFile:cacheFile context:context];
			[parseOperation addDependency:downloadOperation];
			[queue addOperation:parseOperation];

			NSBlockOperation *doneOperation = [NSBlockOperation blockOperationWithBlock:done];
			[doneOperation addDependency:parseOperation];
			[queue addOperation:doneOperation];

			queue.suspended = NO;
		});
		expect([[context insertedObjects] count]).to.equal(81);
	});

});

SpecEnd
