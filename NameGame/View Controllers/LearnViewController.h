//
//  LearnViewController.h
//  NameGame
//
//  Created by Nate Armstrong on 8/14/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

@import UIKit;
@import CoreData;

#import "SwipeStackView.h"

@interface LearnViewController : UIViewController <SwipeStackViewDataSource, SwipeStackViewDelegate>

@property (nonatomic, strong) IBOutlet SwipeStackView *membersStackView;
@property (nonatomic, strong) NSManagedObjectContext *context;

- (IBAction)againButtonTapped:(id)sender;

@end
