//
//  DRLogger.m
//  DoradaCore
//
//  Created by Daniel Broad on 03/10/2013.
//  Copyright (c) 2013 Dorada. All rights reserved.
//

#import "DRLogger.h"
#import "DRApplicationPaths.h"

@implementation DRLogger {
    NSMutableString *_log;
    NSDateFormatter *_formatter;
    
    NSString *_identifier;
    BOOL _persistent;
    
    NSOperationQueue *_loggerQueue;
}

-(id) init {
    NSAssert(0,@"Wrong initialiser");
    return nil;
}

-(id) initWithIdentifier: (NSString*) identifier isPersistent: (BOOL) persistent {
    self = [super init];
    if (self) {
        _identifier = identifier;
        _persistent = persistent;
        _log = [NSMutableString string];
        _formatter = [[NSDateFormatter alloc] init];
        [_formatter setDateStyle:NSDateFormatterShortStyle];
        [_formatter setTimeStyle:NSDateFormatterMediumStyle];
        
        NSData *data = [NSData dataWithContentsOfFile:[self myPath]];
        
        if (data && persistent && data.length < 1024*1024) {
            _log = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            if (_log.length > 1024*50) {
                @try { // this can never crash
                    _log = [[_log substringFromIndex:1024*40] mutableCopy];
                }
                @catch (NSException *exception) {
                }

            }
        }
        
        _loggerQueue = [[NSOperationQueue alloc] init];
        _loggerQueue.maxConcurrentOperationCount = 1;
        
        [self appendLog:@"Log Begins..."];
    }
    return self;
}

-(NSString*) persistantFilePath {
    NSAssert(_persistent,@"Must be set to persistant for this");
    NSData *logData = [_log dataUsingEncoding:NSUTF8StringEncoding];
    NSString *path = [[[DRApplicationPaths applicationCachesDirectory] stringByAppendingPathComponent:_identifier] stringByAppendingPathExtension:@"log"];
    [logData writeToFile:path atomically:YES];
    return path;
}

-(NSString*) myPath {
    return [[DRApplicationPaths applicationCachesDirectory] stringByAppendingPathComponent:_identifier];
}

-(void) save {
    if (_log.length > 1024*50) {
        @try { // this can never crash
            _log = [[_log substringFromIndex:1024*40] mutableCopy];
        }
        @catch (NSException *exception) {
        }
        
    }
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_log];
    [data writeToFile:[self myPath] atomically:YES];
}

-(void) appendLog: (NSString*) string {
    if (string) {
        [_loggerQueue addOperationWithBlock:^{
            [_log appendString:[NSString stringWithFormat:@"%@: %@\n",[_formatter stringFromDate:[NSDate date]],string]];
            NSLog(@"%@",string);
            if (_persistent) {
                [self save];
            }
        }];
        
    }
}

-(void) appendLog: (NSString*) string withParam: (id) param {
    NSString *log = [NSString stringWithFormat:string,param];
    [self appendLog:log];
}

-(NSString*) logAsString {
    return _log;
}
@end
