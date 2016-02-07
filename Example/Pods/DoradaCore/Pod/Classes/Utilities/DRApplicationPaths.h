//
//  DRApplicationPaths.h
//  DoradaCore
//
//  Created by Daniel Broad on 21/03/2014.
//  Copyright (c) 2014 Dorada. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DRApplicationPaths : NSObject

+(NSString *)applicationDocumentsDirectory;
+(NSString *)applicationCachesDirectory;
+(NSString *)applicationHiddenDocumentsDirectory;

+(NSString *)temporaryFilenameWithExtension: (NSString*) extension;

@end
