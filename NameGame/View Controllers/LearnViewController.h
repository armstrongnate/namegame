//
//  LearnViewController.h
//  NameGame
//
//  Created by Nate Armstrong on 8/14/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

@import UIKit;

#import "SwipeStackView.h"

@interface LearnViewController : UIViewController <SwipeStackViewDataSource>

@property (nonatomic, strong) IBOutlet SwipeStackView *membersStackView;

@end
