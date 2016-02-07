//
//  DRApplicationPaths.m
//  DoradaCore
//
//  Created by Daniel Broad on 21/03/2014.
//  Copyright (c) 2014 Dorada. All rights reserved.
//

#import "DRApplicationPaths.h"

@implementation DRApplicationPaths

+(NSString *)applicationDocumentsDirectory {
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSAssert(paths != nil,@"documents directory array cannot be nil!");
	NSAssert([paths count]>0,@"documents directory array cannot be zero size!");
	NSAssert([[paths objectAtIndex:0] length]>0,@"documents directory cannot be zero size!");
	return [paths objectAtIndex:0];
    
}

+(NSString *)applicationCachesDirectory {
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSAssert(paths != nil,@"directory array cannot be nil!");
	NSAssert([paths count]>0,@"directory array cannot be zero size!");
	NSAssert([[paths objectAtIndex:0] length]>0,@"directory cannot be zero size!");
	return [paths objectAtIndex:0];
    
}

+ (NSString *)applicationHiddenDocumentsDirectory {
    // NSString *path = [[self applicationDocumentsDirectory] stringByAppendingPathComponent:@".data"];
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [libraryPath stringByAppendingPathComponent:@"Private Documents"];
    
    BOOL isDirectory = NO;
    if ([[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory]) {
        if (isDirectory)
            return path;
        else {
            // Handle error. ".data" is a file which should not be there...
            [NSException raise:@".data exists, and is a file" format:@"Path: %@", path];
            // NSError *error = nil;
            // if (![[NSFileManager defaultManager] removeItemAtPath:path error:&error]) {
            //     [NSException raise:@"could not remove file" format:@"Path: %@", path];
            // }
        }
    }
    NSError *error = nil;
    if (![[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error]) {
        // Handle error.
        [NSException raise:@"Failed creating directory" format:@"[%@], %@", path, error];
    }
    return path;
}

+(NSString *)temporaryFilenameWithExtension: (NSString*) extension {
    NSProcessInfo			*proc = [NSProcessInfo processInfo];
    return [[proc globallyUniqueString] stringByAppendingPathExtension:extension];
    
}
@end
