//
//  DRSingleton.m
//  DoradaCore
//
//  Created by Daniel Broad on 19/05/2014.
//  Copyright (c) 2014 Dorada. All rights reserved.
//

#import "DRSingleton.h"

static NSMutableDictionary *singletons;

@implementation DRSingleton

+(void) initialize {
    if (!singletons) {
        singletons = [NSMutableDictionary dictionary];
    }
}

+(instancetype) sharedInstance {
    id singleton;
    singleton = [singletons objectForKey:NSStringFromClass(self)];
    if (!singleton) {
        singleton = [[self alloc] init];
        [singletons setObject:singleton forKey:NSStringFromClass(self)];
    };
    return singleton;
}

-(id) init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

@end
