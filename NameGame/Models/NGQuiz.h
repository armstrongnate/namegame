//
//  NGQuiz.h
//  NameGame
//
//  Created by Nate Armstrong on 8/17/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

@import Foundation;

@interface NGQuizQuestion : NSObject

- (instancetype)initWithAnswer:(NSObject *)answer choices:(NSArray *)choices;

@property (nonatomic, strong) NSObject *answer;
@property (nonatomic, strong) NSArray *choices;

@end

@interface NGQuiz : NSObject

@property (nonatomic, strong) NSArray *objects;
@property (nonatomic) NSUInteger numberOfAnswers;

- (NGQuizQuestion *)nextQuestion;
- (BOOL)checkAnswer:(NSObject *)answer toQuestion:(NGQuizQuestion *)question;
- (void)reset;
- (NSUInteger)score;

@end
