//
//  NGDownloadMembersOperation.h
//  NameGame
//
//  Created by Nate Armstrong on 8/13/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

#import "NGGroupOperation.h"

@interface NGDownloadMembersOperation : NGGroupOperation

- (instancetype)initWithCacheFile:(NSURL *)cacheFile;

@end
