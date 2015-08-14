//
//  PersistenceHelper.h
//  NameGame
//
//  Created by Nate Armstrong on 8/13/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

@import Foundation;
@import CoreData;

@interface NGPersistenceHelper : NSObject

@property (nonatomic, strong) NSManagedObjectContext *context;

@end
