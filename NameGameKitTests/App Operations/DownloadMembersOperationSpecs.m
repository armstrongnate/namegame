//
//  DownloadMembersOperationSpecs.m
//  NameGame
//
//  Created by Nate Armstrong on 8/13/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

@import Foundation;
@import Specta;
@import Expecta;

#import "NGDownloadMembersOperation.h"

SpecBegin(NGDownloadMembersOperationSpec)

describe(@"DownloadMembersOperationSpec", ^{

	it(@"downloads members json", ^{
		NSError *error = nil;
		NSURL *cacheFolder = [[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory
																	inDomain:NSUserDomainMask
														   appropriateForURL:nil
																	  create:nil
																	   error:&error];
		expect(error).to.beNil();
		NSURL *cacheFile = [cacheFolder URLByAppendingPathComponent:@"members.json"];
		__block NGDownloadMembersOperation *membersOperation;
		waitUntil(^(DoneCallback done) {
    		NSOperationQueue *queue = [NSOperationQueue new];
			queue.suspended = true;

    		membersOperation = [[NGDownloadMembersOperation alloc] initWithCacheFile:cacheFile];
			[queue addOperation:membersOperation];

			NSOperation *doneOperation = [NSBlockOperation blockOperationWithBlock:done];
			[doneOperation addDependency:membersOperation];
			[queue addOperation:doneOperation];

			queue.suspended = false;
		});
		expect([[NSFileManager defaultManager] fileExistsAtPath:cacheFile.path]).to.beTruthy();
	});
});

SpecEnd
