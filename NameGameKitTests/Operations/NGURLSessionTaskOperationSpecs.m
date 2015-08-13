//
//  NGURLSessionTaskOperationSpecs.m
//  NameGame
//
//  Created by Nate Armstrong on 8/13/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

@import Foundation;
@import Specta;
@import Expecta;

#import "NGURLSessionTaskOperation.h"

SpecBegin(NGURLSessionTaskOperationSpec)

describe(@"NGURLSessionTaskOperation", ^{
	it(@"should complete task and finish operation", ^{
		__block NSURLSessionTask *task;
		__block NGURLSessionTaskOperation *taskOperation;
		waitUntil(^(DoneCallback done) {
        	NSOperationQueue *queue = [NSOperationQueue new];
			queue.suspended = true;

        	NSURL *url = [NSURL URLWithString:@"http://api.namegame.willowtreemobile.com/"];
			task = [[NSURLSession sharedSession] downloadTaskWithURL:url];
			taskOperation = [[NGURLSessionTaskOperation alloc] initWithTask:task];
			[queue addOperation:taskOperation];

			NSBlockOperation *doneOperation = [NSBlockOperation blockOperationWithBlock:done];
			[doneOperation addDependency:taskOperation];
			[queue addOperation:doneOperation];

			queue.suspended = false;
		});
		expect(task.state).to.equal(NSURLSessionTaskStateCompleted);
		expect(taskOperation.finished).to.beTruthy();
	});
});

SpecEnd
