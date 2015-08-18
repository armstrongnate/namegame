//
//  NGPreferences.h
//  NameGame
//
//  Created by Nate Armstrong on 8/17/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

@import Foundation;

@interface NGPreferences : NSObject

- (BOOL)hasDownloadedMembers;
- (void)setHasDownloadedMembers:(BOOL)hasDownloadedMembers;

@end
