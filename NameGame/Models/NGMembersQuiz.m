//
//  NGMembersQuiz.m
//  NameGame
//
//  Created by Nate Armstrong on 8/17/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

@import NameGameKit;

#import "NGMembersQuiz.h"

@implementation NGMembersQuiz

- (instancetype)initWithContext:(NSManagedObjectContext *)context
{
	if (!(self = [super init])) return nil;
	self.objects = [self allMembersInContext:context];
	self.numberOfAnswers = 4;
	return self;
}

- (NSArray *)allMembersInContext:(NSManagedObjectContext *)context
{
	NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:[NGMember entityName]];
	request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name"
															  ascending:YES
															   selector:@selector(localizedCaseInsensitiveCompare:)]];
	request.predicate = nil;
	NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
																		managedObjectContext:context
																		  sectionNameKeyPath:nil
																				   cacheName:nil];
	NSError *fetchError = nil;
	[fetchedResultsController performFetch:&fetchError];
	if (fetchError == nil) return [fetchedResultsController fetchedObjects];
	return @[];
}

@end
