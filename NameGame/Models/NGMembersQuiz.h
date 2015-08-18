//
//  NGMembersQuiz.h
//  NameGame
//
//  Created by Nate Armstrong on 8/17/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

@import CoreData;

#import "NGQuiz.h"

@interface NGMembersQuiz : NGQuiz

- (instancetype)initWithContext:(NSManagedObjectContext *)context;

@end
