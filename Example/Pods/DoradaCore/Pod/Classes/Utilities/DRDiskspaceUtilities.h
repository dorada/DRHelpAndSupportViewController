//
//  DRDiskspaceUtilities.h
//  DoradaCore
//
//  Created by Daniel Broad on 13/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DRDiskspaceUtilities : NSObject {

}

+(float) getFreeDiskSpaceInBytes;
+(float) getFreeDiskSpaceInMegaBytes;
+(float) getUsedSpaceInMegaBytes;
+(int) getTotalFileCount;
+(NSString *)applicationDocumentsDirectory;
    
typedef void (^CompletionHandler)(float megabytes);
+(void) getTotalUsedSpaceInMegaBytesOnBackgroundThreadCompletion: (CompletionHandler) completion;
@end
