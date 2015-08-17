//
//  MemberView.h
//  NameGame
//
//  Created by Nate Armstrong on 8/15/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

@import UIKit;
@import NameGameKit;

@interface MemberView : UIView

@property (nonatomic, strong) NGMember *member;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIButton *showNameButton;

- (instancetype)initWithMember:(NGMember *)member;

@end
