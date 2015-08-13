//
//  NGGroupOperation.h
//  NameGame
//
//  Created by Nate Armstrong on 8/12/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

#import "NGOperation.h"

@interface NGGroupOperation : NGOperation

- (instancetype)initWithOperations:(NSArray *)operations;
- (void)addOperation:(NSOperation *)operation;

@end
