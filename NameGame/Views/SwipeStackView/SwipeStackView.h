//
//  SwipeStackView.h
//  NameGame
//
//  Created by Nate Armstrong on 8/14/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

@import UIKit;

@class SwipeStackView;

@protocol SwipeStackViewDataSource

- (UIView *)swipeStackView:(SwipeStackView *)swipeStackView viewForIndexPath:(NSIndexPath *)indexPath;
- (NSUInteger)numberOfViewsInStack;

@end

@interface SwipeStackView : UIView

@property (nonatomic, weak) id <SwipeStackViewDataSource> dataSource;

- (void)reload;

@end
