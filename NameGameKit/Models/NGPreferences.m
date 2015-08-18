//
//  NGPreferences.m
//  NameGame
//
//  Created by Nate Armstrong on 8/17/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

#import "NGPreferences.h"

NSString * const HasDownloadedMembersKey = @"hasDownloadedMembers";

@implementation NGPreferences

- (BOOL)hasDownloadedMembers
{
	return [[NSUserDefaults standardUserDefaults] boolForKey:HasDownloadedMembersKey];
}

- (void)setHasDownloadedMembers:(BOOL)hasDownloadedMembers
{
	[[NSUserDefaults standardUserDefaults] setBool:hasDownloadedMembers forKey:HasDownloadedMembersKey];
}

@end
