//
//  NGURLSessionTaskOperation.h
//  NameGame
//
//  Created by Nate Armstrong on 8/12/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

#import "NGGroupOperation.h"

@interface NGURLSessionTaskOperation : NGOperation

- (instancetype)initWithTask:(NSURLSessionTask *)task;

@end
