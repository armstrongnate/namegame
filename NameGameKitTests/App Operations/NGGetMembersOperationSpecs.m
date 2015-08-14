//
//  NGGetMembersOperationSpecs.m
//  NameGame
//
//  Created by Nate Armstrong on 8/14/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

@import Foundation;
@import Specta;
@import Expecta;
@import CoreData;

#import "NGGetMembersOperation.h"
#import "NGPersistenceHelper.h"

SpecBegin(NGGetMembersOperationSpec)

describe(@"NGGetMembersOperation", ^{

	__block NSManagedObjectContext *context;
	beforeAll(^{
		context = [[[NGPersistenceHelper alloc] init] context];
	});

	afterEach(^{
		[context reset];
	});

	it(@"is initialized with a context and completion handler", ^{
		NGGetMembersOperation *getMembersOperation = [[NGGetMembersOperation alloc] initWithContext:context completionHandler:nil];
		expect(getMembersOperation).toNot.beNil();
	});

	it(@"should finish", ^{
		waitUntil(^(DoneCallback done) {
			NSOperationQueue *queue = [NSOperationQueue new];
    		NGGetMembersOperation *getOperation = [[NGGetMembersOperation alloc] initWithContext:context completionHandler:done];
			[queue addOperation:getOperation];
		});
		expect(context.insertedObjects.count).to.equal(81);
	});

});

SpecEnd
