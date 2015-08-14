//
//  NGParseMembersOperation.m
//  NameGame
//
//  Created by Nate Armstrong on 8/13/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

#import "NGParseMembersOperation.h"
#import "NGMember.h"

@interface NGParseMembersOperation ()

@property (nonatomic, strong) NSURL *cacheFile;
@property (nonatomic, strong) NSManagedObjectContext *importContext;

@end

@implementation NGParseMembersOperation

- (instancetype)initWithCacheFile:(NSURL *)cacheFile context:(NSManagedObjectContext *)context
{
	if (!(self = [super init])) return nil;

	self.cacheFile = cacheFile;
	self.importContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
	self.importContext.parentContext = context;
	self.importContext.mergePolicy = NSOverwriteMergePolicy;

	return self;
}

- (void)execute
{
	NSArray *parsedMembers = [self parseMembers];
	NSAssert(parsedMembers != nil, @"Failed to parse response");
	[self importMembers:parsedMembers];
	[self finish];
}

- (NSArray *)parseMembers
{
	NSInputStream *inputStream = [NSInputStream inputStreamWithURL:self.cacheFile];
	NSAssert(inputStream != nil, @"No file at url %@", self.cacheFile.path);
	[inputStream open];

	NSError *jsonError;
	NSArray *json = [NSJSONSerialization JSONObjectWithStream:inputStream options:0 error:&jsonError];

	NSAssert(jsonError == nil && json != nil, @"JSON error: %@", jsonError);

	[inputStream close];

	return json;
}

- (void)importMembers:(NSArray *)parsedMembers
{
	[parsedMembers enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL *stop) {
		[self.importContext performBlock:^{
			NGMember *member = [NGMember insertNewObjectInContext:self.importContext];
			member.name = dict[@"name"];
			member.pictureUrl = dict[@"url"];

    		NSError *saveError;
    		[self.importContext save:&saveError];
    		NSAssert(saveError == nil, @"Save error: %@", saveError);
		}];

	}];
}

@end
