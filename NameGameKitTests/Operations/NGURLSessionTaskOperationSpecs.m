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
#import "OCMock.h"

#import "NGURLSessionTaskOperation.h"

SpecBegin(NGURLSessionTaskOperationSpec)

describe(@"NGURLSessionTaskOperation", ^{
	it(@"should complete task and finish operation", ^{
		__block NSURLSessionTask *task;
		__block NGURLSessionTaskOperation *taskOperation;
		__block id taskOperationMock;
		waitUntil(^(DoneCallback done) {
        	NSOperationQueue *queue = [NSOperationQueue new];
        	NSURL *url = [NSURL URLWithString:@"http://api.namegame.willowtreemobile.com/"];
        	void (^completionHandler)(NSURL *url , NSURLResponse *response, NSError *error) = ^void(NSURL *url, NSURLResponse *response, NSError *error) {
				done();
        	};
        	task = [[NSURLSession sharedSession] downloadTaskWithURL:url completionHandler:completionHandler];
			taskOperation = [[NGURLSessionTaskOperation alloc] initWithTask:task];
			taskOperationMock = [OCMockObject partialMockForObject:taskOperation];
			[queue addOperation:taskOperation];
		});
		expect(task.state).to.equal(NSURLSessionTaskStateCompleted);
		expect(taskOperation.finished).to.beTruthy();
		[[taskOperationMock verify] finish];
	});
});

SpecEnd
