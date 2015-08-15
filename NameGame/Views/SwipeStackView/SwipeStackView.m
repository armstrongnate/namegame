//
//  SwipeStackView.m
//  NameGame
//
//  Created by Nate Armstrong on 8/14/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

#import "SwipeStackView.h"

// max number of views to reuse
NSUInteger const NumberOfViewsInStack = 3;

@interface SwipeStackView ()

@property (nonatomic, strong) NSIndexPath *currentIndexPath;
@property (nonatomic, strong) UIDynamicAnimator *animator;

@end

@implementation SwipeStackView

- (instancetype)init
{
	if (!(self = [super init])) return nil;
	[self setup];
	return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
	if (!(self = [super initWithFrame:frame])) return nil;
	[self setup];
	return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	if (!(self = [super initWithCoder:aDecoder])) return nil;
	[self setup];
	return self;
}

# pragma mark - Instance Methods

- (void)setup
{
	self.currentIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
	self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
	if (self.dataSource != nil) [self load];
}

- (void)load
{
	for (int i=0; i<NumberOfViewsInStack; i++) {
		[self askDataSourceForView];
	}
}

- (void)reload
{
	[self.subviews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
		[view removeFromSuperview];
	}];
	self.currentIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
	[self load];
}

- (id)dequeueReusableViewForIndexPath:(NSIndexPath *)indexPath
{
	if ([self.subviews count] < 3) return nil;
	return [self.subviews firstObject];
}

- (UIView *)askDataSourceForView
{
	UIView *view = [self.dataSource swipeStackView:self viewForIndexPath:self.currentIndexPath];
	[self addSubview:view];
	[self sendSubviewToBack:view];
	UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan:)];
	[view addGestureRecognizer:pan];
	self.currentIndexPath = [NSIndexPath indexPathForItem:self.currentIndexPath.item + 1 inSection:0];
	return view;
}

# pragma mark - Gesture Recognizer

- (void)didPan:(UIPanGestureRecognizer *)gesture
{
	static UIAttachmentBehavior *attachment;
	static CGPoint startCenter;

	if (gesture.state == UIGestureRecognizerStateBegan)
	{
		[self.animator removeAllBehaviors];
		startCenter = gesture.view.center;
		CGPoint point = [gesture locationInView:gesture.view];
		UIOffset offset = UIOffsetMake(point.x - gesture.view.bounds.size.width / 2, point.y - gesture.view.bounds.size.height / 2);
		attachment = [[UIAttachmentBehavior alloc] initWithItem:gesture.view offsetFromCenter:offset attachedToAnchor:[gesture locationInView:self]];
		[self.animator addBehavior:attachment];
	}
	else if (gesture.state == UIGestureRecognizerStateChanged)
	{
		CGPoint loc = [gesture locationInView:self];
		attachment.anchorPoint = CGPointMake(loc.x, attachment.anchorPoint.y);
	}
	else if (gesture.state == UIGestureRecognizerStateEnded)
	{
		[self.animator removeAllBehaviors];
		const CGFloat DragAmount = 200;
		const CGFloat Threshold = 0.4;

		CGPoint translation = [gesture translationInView:self];
		CGPoint velocity = [gesture velocityInView:self];
		CGFloat translationAmount = fabs(velocity.x);
		CGFloat percent = translationAmount / DragAmount;
		percent = fmaxf(percent, 0.0);
		percent = fminf(percent, 1.0);
		if (percent >= Threshold)
		{
    		if (self.currentIndexPath.item < [self.dataSource numberOfViewsInStack])
    		{
        		[self askDataSourceForView];
    		}
			UIPushBehavior *push = [[UIPushBehavior alloc] initWithItems:@[gesture.view] mode:UIPushBehaviorModeInstantaneous];
			push.pushDirection = CGVectorMake(velocity.x * 2, velocity.y * 2);
			CGFloat velocityMagnitude = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));
			push.magnitude = MAX(200, velocityMagnitude / 35.0);
			typeof(self) __weak weakSelf = self;
			push.action = ^{
				if (!CGRectIntersectsRect(gesture.view.frame, self.superview.bounds))
				{
					[weakSelf.animator removeAllBehaviors];
            		[gesture.view removeFromSuperview];
				}
			};
			[self.animator addBehavior:push];
		}
		else
		{
			UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:gesture.view snapToPoint:startCenter];
			[self.animator addBehavior:snap];
			return;
		}

	}
}

@end
