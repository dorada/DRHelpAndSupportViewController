//
//  DRABTestingController.h
//  DoradaCore
//
//  Created by Daniel Broad on 06/11/2013.
//  Copyright (c) 2013 Dorada. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DRABTestingController : NSObject

+(DRABTestingController *)sharedInstance;

-(BOOL) isA;
-(BOOL) isB;
-(NSString*) variant;

@end
