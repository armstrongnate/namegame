//
//  NGDownloadMembersOperation.m
//  NameGame
//
//  Created by Nate Armstrong on 8/13/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

#import "NGDownloadMembersOperation.h"
#import "NGURLSessionTaskOperation.h"

@interface NGDownloadMembersOperation ()

@property (nonatomic, strong) NSURL *cacheFile;

@end

@implementation NGDownloadMembersOperation

- (instancetype)initWithCacheFile:(NSURL *)cacheFile
{
	if (!(self = [super initWithOperations:@[]])) return nil;

	self.cacheFile = cacheFile;

	if ([[NSFileManager defaultManager] fileExistsAtPath:cacheFile.path])
	{
		[[NSFileManager defaultManager] removeItemAtPath:cacheFile.path error:nil];
	}

    NSURL *url = [NSURL URLWithString:@"http://api.namegame.willowtreemobile.com/"];
	NSURLSessionTask *task = [[NSURLSession sharedSession] downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
		[self downloadFinishedWithURL:url response:(NSHTTPURLResponse *)response error:error];
	}];
	NGURLSessionTaskOperation *taskOperation = [[NGURLSessionTaskOperation alloc] initWithTask:task];
	[self addOperation:taskOperation];

	return self;
}

- (void)downloadFinishedWithURL:(NSURL *)url response:(NSHTTPURLResponse *)response error:(NSError *)error
{
	if (error == nil && response.statusCode == 200)
	{
		NSData *data = [NSData dataWithContentsOfURL:url];
		[data writeToURL:self.cacheFile atomically:YES];
	}
    [self finish];
}

@end
