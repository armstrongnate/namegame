//
//  LearnViewController.m
//  NameGame
//
//  Created by Nate Armstrong on 8/14/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

#import "LearnViewController.h"

@interface LearnViewController ()

@property (nonatomic, strong) NSArray *data;

@end

@implementation LearnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.data = @[
				  [UIColor redColor],
				  [UIColor blueColor],
				  [UIColor greenColor],
				  [UIColor yellowColor],
				  [UIColor orangeColor],
				  [UIColor brownColor]
    ];
	self.membersStackView.dataSource = self;
	[self.membersStackView reload];
}

#pragma mark - SwipeStackViewDataSource

- (NSUInteger)numberOfViewsInStack
{
	return self.data.count;
}

- (UIView *)swipeStackView:(SwipeStackView *)swipeStackView viewForIndexPath:(NSIndexPath *)indexPath
{
	UIView *view = [[UIView alloc] initWithFrame:swipeStackView.bounds];
	view.backgroundColor = (UIColor *)[self.data objectAtIndex:indexPath.item];
	return view;
}

@end
