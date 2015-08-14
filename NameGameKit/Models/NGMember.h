//
//  NGMember.h
//  NameGame
//
//  Created by Nate Armstrong on 8/13/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

@import Foundation;
@import CoreData;

@interface NGMember : NSManagedObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *pictureUrl;

+ (instancetype)insertNewObjectInContext:(NSManagedObjectContext *)context;

@end
