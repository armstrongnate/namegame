//
//  MemberView.m
//  NameGame
//
//  Created by Nate Armstrong on 8/15/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

#import "MemberView.h"
#import "JMImageCache.h"

@interface MemberView ()

@property (nonatomic, strong) UIImageView *memorizedImageView;
@property (nonatomic, strong) UIImageView *notMemorizedImageView;

@end

@implementation MemberView

- (instancetype)initWithMember:(NGMember *)member
{
	if (!(self = [super init])) return nil;

	self.member = member;
	[self setup];

	return self;
}

- (void)dealloc
{
	[self.member removeObserver:self forKeyPath:@"memorized"];
}

- (UIImageView *)imageView
{
	if (!_imageView)
	{
		_imageView = [UIImageView new];
		_imageView.contentMode = UIViewContentModeScaleAspectFill;
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

- (UIImageView *)memorizedImageView
{
	if (!_memorizedImageView)
	{
		_memorizedImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"checkmark-on"]];
		_memorizedImageView.hidden = YES;
		_memorizedImageView.transform = CGAffineTransformMakeRotation(-M_PI/6);
		[_memorizedImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
		[self addSubview:_memorizedImageView];
	}
	return _memorizedImageView;
}

- (UIImageView *)notMemorizedImageView
{
	if (!_notMemorizedImageView)
	{
		_notMemorizedImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"checkmark-off"]];
		_notMemorizedImageView.hidden = YES;
		_notMemorizedImageView.transform = CGAffineTransformMakeRotation(M_PI/6);
		[_notMemorizedImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
		[self addSubview:_notMemorizedImageView];
	}
	return _notMemorizedImageView;
}

- (void)setMember:(NGMember *)member
{
	_member = member;
	[member addObserver:self forKeyPath:@"memorized" options:0 context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if (object == self.member && [keyPath isEqualToString:@"memorized"])
	{
		self.memorizedImageView.hidden = !self.member.memorized;
		self.notMemorizedImageView.hidden = self.member.memorized;
	}
}

- (void)setup
{
	CGFloat const cornerRadius = 10.0;
	self.backgroundColor = [UIColor whiteColor];
	self.layer.cornerRadius = cornerRadius;
	self.clipsToBounds = YES;
	self.layer.borderColor = [UIColor lightGrayColor].CGColor;
	self.layer.borderWidth = 1.0;
	[self.imageView setImageWithURL:[NSURL URLWithString:self.member.pictureUrl]];
	self.nameLabel.text = self.member.name;
	[self.nameLabel sizeToFit];
}

- (void)hideMemorizedIndicators
{
	self.memorizedImageView.hidden = YES;
	self.notMemorizedImageView.hidden = YES;
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	[self setTranslatesAutoresizingMaskIntoConstraints:NO];

	UIImageView *imageView = self.imageView;
	UILabel *nameLabel = self.nameLabel;
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[imageView]|"
																 options:0 metrics:nil
																   views:NSDictionaryOfVariableBindings(imageView)]];
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(20)-[nameLabel]-|"
																 options:0 metrics:nil
																   views:NSDictionaryOfVariableBindings(nameLabel)]];
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[imageView]-(34)-[nameLabel(40)]-|"
																 options:0 metrics:nil
																   views:NSDictionaryOfVariableBindings(imageView, nameLabel)]];

	UIImageView *memorized = self.memorizedImageView;
	CGSize const memorizedSize = CGSizeMake(60, 60);
	CGFloat const memorizedMargin = 30;
	[self addConstraints:@[
    	[NSLayoutConstraint constraintWithItem:memorized
									 attribute:NSLayoutAttributeLeading
									 relatedBy:NSLayoutRelationEqual
										toItem:imageView
									 attribute:NSLayoutAttributeLeading
									multiplier:1 constant:memorizedMargin],
    	[NSLayoutConstraint constraintWithItem:memorized
									 attribute:NSLayoutAttributeTop
									 relatedBy:NSLayoutRelationEqual
										toItem:imageView
									 attribute:NSLayoutAttributeTop
									multiplier:1 constant:memorizedMargin],
    	[NSLayoutConstraint constraintWithItem:memorized
									 attribute:NSLayoutAttributeWidth
									 relatedBy:NSLayoutRelationEqual
										toItem:nil
									 attribute:NSLayoutAttributeNotAnAttribute
									multiplier:1 constant:memorizedSize.width],
    	[NSLayoutConstraint constraintWithItem:memorized
									 attribute:NSLayoutAttributeHeight
									 relatedBy:NSLayoutRelationEqual
										toItem:nil
									 attribute:NSLayoutAttributeNotAnAttribute
									multiplier:1 constant:memorizedSize.height]
    ]];

	UIImageView *notMemorized = self.notMemorizedImageView;
	[self addConstraints:@[
    	[NSLayoutConstraint constraintWithItem:notMemorized
									 attribute:NSLayoutAttributeTrailing
									 relatedBy:NSLayoutRelationEqual
										toItem:imageView
									 attribute:NSLayoutAttributeTrailing
									multiplier:1 constant:-memorizedMargin],
    	[NSLayoutConstraint constraintWithItem:notMemorized
									 attribute:NSLayoutAttributeTop
									 relatedBy:NSLayoutRelationEqual
										toItem:imageView
									 attribute:NSLayoutAttributeTop
									multiplier:1 constant:memorizedMargin],
    	[NSLayoutConstraint constraintWithItem:notMemorized
									 attribute:NSLayoutAttributeWidth
									 relatedBy:NSLayoutRelationEqual
										toItem:nil
									 attribute:NSLayoutAttributeNotAnAttribute
									multiplier:1 constant:memorizedSize.width],
    	[NSLayoutConstraint constraintWithItem:notMemorized
									 attribute:NSLayoutAttributeHeight
									 relatedBy:NSLayoutRelationEqual
										toItem:nil
									 attribute:NSLayoutAttributeNotAnAttribute
									multiplier:1 constant:memorizedSize.height]
    ]];
}

@end
