//
//  SwipeStackView.h
//  NameGame
//
//  Created by Nate Armstrong on 8/14/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

@import UIKit;

@class SwipeStackView;

@protocol SwipeStackViewDataSource <NSObject>

- (UIView *)swipeStackView:(SwipeStackView *)swipeStackView viewForIndexPath:(NSIndexPath *)indexPath;
- (NSUInteger)numberOfViewsInStack;

@end

@protocol SwipeStackViewDelegate <NSObject>

@optional
- (void)swipeStackView:(SwipeStackView *)swipeStackView willSwipeView:(UIView *)view withVelocity:(CGPoint)velocity;
- (void)swipeStackView:(SwipeStackView *)swipeStackView didCancelSwipingView:(UIView *)view;
- (void)swipeStackViewDidFinish:(SwipeStackView *)swipStackView;

@end

@interface SwipeStackView : UIView

@property (nonatomic, weak) id <SwipeStackViewDataSource> dataSource;
@property (nonatomic, weak) id <SwipeStackViewDelegate> delegate;

- (void)reload;

@end
