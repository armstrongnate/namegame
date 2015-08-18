//
//  NGQuiz.m
//  NameGame
//
//  Created by Nate Armstrong on 8/17/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

#import "NGQuiz.h"

@implementation NGQuizQuestion

- (instancetype)initWithAnswer:(NSObject *)answer choices:(NSArray *)choices
{
	if (!(self = [super init])) return nil;
	self.answer = answer;
	self.choices = choices;
	return self;
}

@end

@interface NGQuiz () {
	NSUInteger _currentIndex;
	NSUInteger _guesses;
}

@end

@implementation NGQuiz

- (instancetype)init
{
	if (!(self = [super init])) return nil;
	self.objects = @[];
	self.numberOfAnswers = 3;
	_currentIndex = 0;
	_guesses = 0;
	return self;
}

- (NGQuizQuestion *)nextQuestion
{
	if (_currentIndex >= self.objects.count) return nil;
	NSObject *answer = [self.objects objectAtIndex:_currentIndex];
	NSMutableArray *choices = [NSMutableArray arrayWithObject:answer];
	for (int i=0; i<self.numberOfAnswers-1; i++)
	{
		NSObject *choice = [self sampleNotEqualToObjects:choices];
		[choices addObject:choice];
	}
	_currentIndex += 1;
	return [[NGQuizQuestion alloc] initWithAnswer:answer choices:choices];
}

- (BOOL)checkAnswer:(NSObject *)answer toQuestion:(NGQuizQuestion *)question
{
	BOOL correct = answer == question.answer;
	_guesses += 1;
	return correct;
}

- (void)reset
{
	_currentIndex = 0;
}

- (NSUInteger)score
{
	return (_currentIndex * 3) - _guesses + _currentIndex;
}

- (NSObject *)sampleNotEqualToObjects:(NSArray *)objects
{
	NSObject *sample = nil;
	do {
        sample = [self.objects objectAtIndex:arc4random()%[self.objects count]];
	} while([objects containsObject:sample]);
	return sample;
}

@end
