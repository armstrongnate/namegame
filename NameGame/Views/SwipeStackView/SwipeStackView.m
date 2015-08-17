//
//  SwipeStackView.m
//  NameGame
//
//  Created by Nate Armstrong on 8/14/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

#import "SwipeStackView.h"

// max number of views
NSUInteger const NumberOfViewsInStack = 3;

@interface SwipeStackView () {
	BOOL _shouldComplete;
}

@property (nonatomic, strong) NSIndexPath *currentIndexPath;
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) NSArray *centerConstraints;

@end

@implementation SwipeStackView

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
	[self setTranslatesAutoresizingMaskIntoConstraints:NO];
	self.currentIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
	self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
	if (self.dataSource != nil) [self load];
}

- (void)load
{
	NSUInteger numViews = MIN([self.dataSource numberOfViewsInStack], NumberOfViewsInStack);
	for (int i=0; i<numViews; i++) {
		[self askDataSourceForView];
	}
	UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan:)];
	[[[self subviews] lastObject] addGestureRecognizer:pan];
}

- (void)reload
{
	[self.subviews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
		[view removeFromSuperview];
	}];
	self.currentIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
	[self load];
}

- (UIView *)askDataSourceForView
{
	UIView *view = [self.dataSource swipeStackView:self viewForIndexPath:self.currentIndexPath];
	[view setTranslatesAutoresizingMaskIntoConstraints:NO];
	[self addSubview:view];

	// center x
	[self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];

	// center y
	[self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];

	// equal width
	[self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];

	// equal height
	[self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];

	[self sendSubviewToBack:view];
	self.currentIndexPath = [NSIndexPath indexPathForItem:self.currentIndexPath.item + 1 inSection:0];
	return view;
}

# pragma mark - Gesture Recognizer

- (void)didPan:(UIPanGestureRecognizer *)gesture
{
	static CGPoint startCenter;
	switch (gesture.state)
	{
		case UIGestureRecognizerStateBegan:
		{
			startCenter = gesture.view.center;
			[self.animator removeAllBehaviors];
			break;
		}
		case UIGestureRecognizerStateChanged:
		{
			CGPoint translation = [gesture translationInView:self.superview];
			gesture.view.center = CGPointMake(gesture.view.center.x + translation.x, gesture.view.center.y);
			CGFloat ratio = self.frame.size.width / translation.x * 2;
			gesture.view.transform = CGAffineTransformRotate(gesture.view.transform, M_PI_2 / ratio);
			[gesture setTranslation:CGPointZero inView:self.superview];

			const CGFloat DragAmount = 200;
			const CGFloat Threshold = 0.4;

			CGPoint velocity = [gesture velocityInView:self];
			CGFloat translationAmount = fabs(velocity.x);
			CGFloat percent = translationAmount / DragAmount;
			percent = fmaxf(percent, 0.0);
			percent = fminf(percent, 1.0);
			_shouldComplete = percent >= Threshold;
			break;
		}
		case UIGestureRecognizerStateEnded:
		case UIGestureRecognizerStateCancelled:
			[self.animator removeAllBehaviors];
			if (gesture.state == UIGestureRecognizerStateCancelled || !_shouldComplete)
			{
				[self cancelSwipeGesture:gesture startCenter:startCenter];
			}
			else
			{
    			[self finishSwipe:gesture startCenter:startCenter];
			}
			break;
		default:
			break;
	}
}

- (void)finishSwipe:(UIPanGestureRecognizer *)gesture startCenter:(CGPoint)startCenter;
{
	CGPoint velocity = [gesture velocityInView:self];
	UIPushBehavior *push = [[UIPushBehavior alloc] initWithItems:@[gesture.view] mode:UIPushBehaviorModeInstantaneous];
	push.pushDirection = CGVectorMake(velocity.x * 3, velocity.y);
	CGFloat velocityMagnitude = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));
	push.magnitude = MAX(200, velocityMagnitude / 35.0);
	typeof(self) __weak weakSelf = self;
	push.action = ^{
		if (!CGRectIntersectsRect(gesture.view.frame, self.superview.bounds))
		{
        	if (self.currentIndexPath.item < [self.dataSource numberOfViewsInStack])
        	{
        		[self askDataSourceForView];
        	}
			[weakSelf.animator removeAllBehaviors];
			[gesture.view removeFromSuperview];
			UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan:)];
			[[[self subviews] lastObject] addGestureRecognizer:pan];
		}
	};
	[self.animator addBehavior:push];
}

- (void)cancelSwipeGesture:(UIPanGestureRecognizer *)gesture startCenter:(CGPoint)center
{
	UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:gesture.view snapToPoint:center];
	snap.damping = 1.0;
	[self.animator addBehavior:snap];
}

@end
