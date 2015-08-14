//
//  NGMemberSpecs.m
//  NameGame
//
//  Created by Nate Armstrong on 8/13/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

@import Foundation;
@import Specta;
@import Expecta;

#import "NGMember.h"
#import "NGPersistenceHelper.h"

SpecBegin(NGMemberSpec)

describe(@"NGMember", ^{
	it(@"can be inserted into context", ^{
		NSManagedObjectContext *context = [[[NGPersistenceHelper alloc] init] context];
		NGMember *member = [NGMember insertNewObjectInContext:context];
		expect(member).toNot.beNil();
		expect([context insertedObjects]).to.haveACountOf(1);
	});
});

SpecEnd
