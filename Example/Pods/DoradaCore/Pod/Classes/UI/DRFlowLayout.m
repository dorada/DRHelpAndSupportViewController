//
//  DRFlowLayout.m
//  DoradaCore
//
//  Created by Daniel Broad on 13/09/2013.
//  Copyright (c) 2013 Dorada. All rights reserved.
//

#import "DRFlowLayout.h"

@implementation DRFlowLayout

-(UICollectionViewLayoutAttributes*) layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    @try {
        return [super layoutAttributesForItemAtIndexPath: indexPath];
    }
    @catch (NSException *exception) {
        return [[UICollectionViewLayoutAttributes alloc] init];
    }
    return nil;
}

@end
