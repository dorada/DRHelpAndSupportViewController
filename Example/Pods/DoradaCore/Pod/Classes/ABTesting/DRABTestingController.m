//
//  DRABTestingController.m
//  DoradaCore
//
//  Created by Daniel Broad on 06/11/2013.
//  Copyright (c) 2013 Dorada. All rights reserved.
//

#import "DRABTestingController.h"

static NSString *const kUserDefault = @"ABTestingVarient";

@implementation DRABTestingController {
    BOOL _variant;
}

+(DRABTestingController *)sharedInstance {
    static DRABTestingController *sharedInstance = nil;
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^{
        sharedInstance = [[DRABTestingController alloc] init];
    });
    
    return sharedInstance;
}

-(id) init {
    self = [super init];
    if (self) {
        NSInteger randomNumber = [[NSUserDefaults standardUserDefaults] integerForKey:kUserDefault]-1;
        if (randomNumber < 0) {
            NSInteger var = arc4random_uniform(100);
            randomNumber = var;
            [[NSUserDefaults standardUserDefaults] setInteger:var+1 forKey:kUserDefault];
        }
        
        _variant = (randomNumber >= 50);
    }
    return self;
}

-(BOOL) isA {
    return _variant;
}

-(BOOL) isB {
    return !_variant;
}

-(NSString*) variant {
    return [self isA]?@"A":@"B";
}
@end
