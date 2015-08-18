//
//  NGPreferencesSpecs.m
//  NameGame
//
//  Created by Nate Armstrong on 8/17/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

@import Foundation;
@import Specta;
@import Expecta;

#import "NGPreferences.h"

SpecBegin(NGPreferencesSpec)

describe(@"NGPreferences", ^{

	it(@"contains state for downloaded members", ^{
		NGPreferences *prefs = [[NGPreferences alloc] init];
		[prefs setHasDownloadedMembers:YES];
		expect([prefs hasDownloadedMembers]).to.beTruthy();
		[prefs setHasDownloadedMembers:NO];
		expect([prefs hasDownloadedMembers]).to.beFalsy();
	});

});

SpecEnd
