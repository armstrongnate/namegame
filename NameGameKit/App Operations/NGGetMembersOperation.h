//
//  NGGetMembersOperation.h
//  NameGame
//
//  Created by Nate Armstrong on 8/14/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

@import CoreData;

#import "NGGroupOperation.h"

@interface NGGetMembersOperation : NGGroupOperation

- (instancetype)initWithContext:(NSManagedObjectContext *)context completionHandler:(void(^)())completion;

@end
