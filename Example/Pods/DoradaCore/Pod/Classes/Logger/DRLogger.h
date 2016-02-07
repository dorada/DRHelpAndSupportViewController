//
//  DRLogger.h
//  DoradaCore
//
//  Created by Daniel Broad on 03/10/2013.
//  Copyright (c) 2013 Dorada. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DRLogger : NSObject

-(id) initWithIdentifier: (NSString*) identifier isPersistent: (BOOL) persistent;

-(NSString*) logAsString;
-(void) appendLog: (NSString*) string;
-(void) appendLog: (NSString*) string withParam: (id) param;
-(NSString*) persistantFilePath;

@end
