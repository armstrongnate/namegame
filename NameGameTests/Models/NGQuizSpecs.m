//
//  NGQuiz.m
//  NameGame
//
//  Created by Nate Armstrong on 8/17/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

@import NameGameKit;
@import Specta;
@import Expecta;

#import "NGPersistenceHelper.h"
#import "NGQuiz.h"

SpecBegin(NGQuizSpec)

describe(@"NGQuiz", ^{

	__block NGQuiz *quiz;
	beforeEach(^{
		quiz = [[NGQuiz alloc] init];
		quiz.objects = @[@"Alice", @"Bob", @"Charlie"];
	});

	afterEach(^{
		[quiz reset];
	});

	it(@"has an array of objects", ^{
		expect(quiz.objects).to.beKindOf([NSArray class]);
		expect(quiz.objects).to.haveACountOf(3);
	});

	it(@"can set number of answers", ^{
		quiz.numberOfAnswers = 4;
		expect(quiz.numberOfAnswers).to.equal(4);
	});

	it(@"can generate a question", ^{
		NGQuizQuestion *question = [quiz nextQuestion];
		expect(question.answer).to.equal(@"Alice");
		expect([question.choices containsObject:@"Alice"]).to.beTruthy();
		expect([question.choices containsObject:@"Bob"]).to.beTruthy();
		expect([question.choices containsObject:@"Alice"]).to.beTruthy();
	});

	it(@"checks answer", ^{
		NGQuizQuestion *question = [quiz nextQuestion];
		BOOL correct = [quiz checkAnswer:@"Bob" toQuestion:question];
		expect(correct).to.beFalsy();
		correct = [quiz checkAnswer:@"Alice" toQuestion:question];
	});

	it(@"calculates perfect score", ^{
		NGQuizQuestion *question = [quiz nextQuestion];
		[quiz checkAnswer:@"Alice" toQuestion:question];
		expect([quiz score]).to.equal(3);
		question = [quiz nextQuestion];
		[quiz checkAnswer:@"Bob" toQuestion:question];
		expect([quiz score]).to.equal(6);
		question = [quiz nextQuestion];
		[quiz checkAnswer:@"Charlie" toQuestion:question];
		expect([quiz score]).to.equal(9); // 3 points per question
	});

	it(@"calculates not-perfect score", ^{
		NGQuizQuestion *question = [quiz nextQuestion];
		[quiz checkAnswer:@"Bob" toQuestion:question];
		[quiz checkAnswer:@"Alice" toQuestion:question]; // 2 points
		question = [quiz nextQuestion];
		[quiz checkAnswer:@"Alice" toQuestion:question];
		[quiz checkAnswer:@"Bob" toQuestion:question]; // 2 points
		question = [quiz nextQuestion];
		[quiz checkAnswer:@"Alice" toQuestion:question];
		[quiz checkAnswer:@"Bob" toQuestion:question];
		[quiz checkAnswer:@"Charlie" toQuestion:question]; // 1 points
		expect([quiz score]).to.equal(5);
	});

	it(@"returns nil for next question if there are no more", ^{
		NGQuizQuestion *question = nil;
		question = [quiz nextQuestion];
		expect(question).toNot.beNil(); // Alice
		question = [quiz nextQuestion];
		expect(question).toNot.beNil(); // Bob
		question = [quiz nextQuestion];
		expect(question).toNot.beNil(); // Charlie
		question = [quiz nextQuestion];
		expect(question).to.beNil(); // end of questions
	});

});

SpecEnd
