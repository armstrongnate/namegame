//
//  MemberView.m
//  NameGame
//
//  Created by Nate Armstrong on 8/15/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

#import "MemberView.h"
#import "JMImageCache.h"

@implementation MemberView

- (instancetype)initWithMember:(NGMember *)member
{
	if (!(self = [super init])) return nil;

	self.member = member;
	[self setup];

	return self;
}

- (UIImageView *)imageView
{
	if (!_imageView)
	{
		_imageView = [UIImageView new];
		[_imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
		[self addSubview:_imageView];
	}
	return _imageView;
}

- (UILabel *)nameLabel
{
	if (!_nameLabel)
	{
		_nameLabel = [UILabel new];
		[_nameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
		[self addSubview:_nameLabel];
	}
	return _nameLabel;
}

- (void)setup
{
	CGFloat const cornerRadius = 10.0;
	self.backgroundColor = [UIColor whiteColor];
	self.layer.cornerRadius = cornerRadius;
	self.clipsToBounds = YES;
	[self.imageView setImageWithURL:[NSURL URLWithString:self.member.pictureUrl]];
	self.nameLabel.text = self.member.name;
	[self.nameLabel sizeToFit];
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	[self setTranslatesAutoresizingMaskIntoConstraints:NO];
	UIImageView *imageView = self.imageView;
	UILabel *nameLabel = self.nameLabel;
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[imageView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(imageView)]];
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[nameLabel]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(nameLabel)]];
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[imageView]-[nameLabel(40)]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(imageView, nameLabel)]];
}

@end
