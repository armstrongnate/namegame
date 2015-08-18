//
//  QuizViewController.m
//  NameGame
//
//  Created by Nate Armstrong on 8/17/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

@import NameGameKit;

#import "QuizViewController.h"
#import "JMImageCache.h"

@interface QuizViewController ()

@property (nonatomic, strong) NGQuizQuestion *question;

@end

@implementation QuizViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self.imageViews enumerateObjectsUsingBlock:^(UIImageView *imageView, NSUInteger idx, BOOL *stop) {
		imageView.userInteractionEnabled = YES;
		UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewWasTapped:)];
		[imageView addGestureRecognizer:tap];
	}];
	[self nextQuestion];
}

- (void)nextQuestion
{
	NGQuizQuestion *question = [self.quiz nextQuestion];
	NGMember *member = (NGMember *)question.answer;
	self.nameLabel.text = member.name;
	[question.choices enumerateObjectsUsingBlock:^(NGMember *member, NSUInteger idx, BOOL *stop) {
		UIImageView *imageView = [self.imageViews objectAtIndex:idx];
		imageView.layer.opacity = 1.0;
		[imageView setImageWithURL:[NSURL URLWithString:member.pictureUrl]];
	}];
	self.question = question;
}

- (void)imageViewWasTapped:(UITapGestureRecognizer *)tap
{
	NSUInteger idx = [self.imageViews indexOfObject:tap.view];
	NGMember *member = [self.question.choices objectAtIndex:idx];
	if ([self.quiz checkAnswer:member toQuestion:self.question])
	{
		[UIView animateWithDuration:0.5 animations:^{
			[self nextQuestion];
		}];
	}
	else
	{
    	tap.view.layer.opacity = 0.5;
	}
}

@end
