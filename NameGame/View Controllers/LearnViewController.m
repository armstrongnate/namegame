//
//  LearnViewController.m
//  NameGame
//
//  Created by Nate Armstrong on 8/14/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

@import NameGameKit;

#import "LearnViewController.h"
#import "MemberView.h"

@interface LearnViewController ()

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end

@implementation LearnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.membersStackView.dataSource = self;
	self.membersStackView.delegate = self;
	[self.membersStackView setTranslatesAutoresizingMaskIntoConstraints:NO];
}

- (void)setContext:(NSManagedObjectContext *)context
{
	_context = context;
	if (context == nil) return;

	NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:[NGMember entityName]];
	request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name"
															  ascending:YES
															   selector:@selector(localizedCaseInsensitiveCompare:)]];
	request.predicate = nil;
	self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
																		managedObjectContext:context
																		  sectionNameKeyPath:nil
																				   cacheName:nil];

	if ([self.fetchedResultsController fetchedObjects].count <= 0)
	{
    	NSOperationQueue *queue = [NSOperationQueue new];
    	NGGetMembersOperation *membersOperation = [[NGGetMembersOperation alloc] initWithContext:context completionHandler:^{
			[self updateUI];
    	}];
    	[queue addOperation:membersOperation];
	}
	[self updateUI];
}

- (void)updateUI
{
	NSError *fetchError = nil;
	[self.fetchedResultsController performFetch:&fetchError];
	if (fetchError == nil)
	{
    	[self.membersStackView reload];
	}
}

- (IBAction)againButtonTapped:(id)sender
{
	[self updateUI];
}

#pragma mark - SwipeStackViewDataSource

- (NSUInteger)numberOfViewsInStack
{
	return [self.fetchedResultsController fetchedObjects].count;
}

- (UIView *)swipeStackView:(SwipeStackView *)swipeStackView viewForIndexPath:(NSIndexPath *)indexPath
{
	NGMember *member = [self.fetchedResultsController objectAtIndexPath:indexPath];
	MemberView *view = [[MemberView alloc] initWithMember:member];
	return view;
}

#pragma - SwipeStackViewDelegate

- (void)swipeStackView:(SwipeStackView *)swipeStackView willSwipeView:(UIView *)view withVelocity:(CGPoint)velocity
{
	MemberView *memberView = (MemberView *)view;
	memberView.member.memorized = velocity.x > 0;
}

- (void)swipeStackView:(SwipeStackView *)swipeStackView didCancelSwipingView:(UIView *)view
{
	MemberView *memberView = (MemberView *)view;
	[memberView hideMemorizedIndicators];
}

@end
