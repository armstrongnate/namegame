//
//  NGMember.m
//  NameGame
//
//  Created by Nate Armstrong on 8/13/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

#import "NGMember.h"

@implementation NGMember

@dynamic name;
@dynamic pictureUrl;
@dynamic memorized;

+ (NSString *)entityName
{
	return @"NGMember";
}

+ (instancetype)insertNewObjectInContext:(NSManagedObjectContext *)context
{
	return [NSEntityDescription insertNewObjectForEntityForName:[self entityName] inManagedObjectContext:context];
}

@end
