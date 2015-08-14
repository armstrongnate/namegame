//
//  NGParseMembersOperation.h
//  NameGame
//
//  Created by Nate Armstrong on 8/13/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

@import CoreData;

#import "NGOperation.h"

@interface NGParseMembersOperation : NGOperation

- (instancetype)initWithCacheFile:(NSURL *)cacheFile context:(NSManagedObjectContext *)context;

@end
