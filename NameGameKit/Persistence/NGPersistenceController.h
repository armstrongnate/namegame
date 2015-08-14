//
//  NGPersistenceController.h
//  NameGame
//
//  Created by Nate Armstrong on 8/13/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

@import Foundation;
@import CoreData;

typedef void (^InitCallbackBlock)(void);

@interface NGPersistenceController : NSObject

- (id)initWithCallback:(InitCallbackBlock)callback;
- (void)save;

@end
