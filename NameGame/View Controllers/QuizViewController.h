//
//  QuizViewController.h
//  NameGame
//
//  Created by Nate Armstrong on 8/17/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

@import UIKit;

#import "NGMembersQuiz.h"

@interface QuizViewController : UIViewController

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imageViews;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *scoreLabel;
@property (nonatomic, strong) NGMembersQuiz *quiz;

- (IBAction)imageViewWasTapped:(UITapGestureRecognizer *)tap;

@end
