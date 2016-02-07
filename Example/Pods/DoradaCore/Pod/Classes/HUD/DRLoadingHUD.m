//
//  DRLoadingHUD.m
//  DoradaCore
//
//  Created by Daniel Broad on 18/06/2014.
//  Copyright (c) 2014 Dorada. All rights reserved.
//

#import "DRLoadingHUD.h"
#import "DRLoadingHUDView.h"
#if !TARGET_OS_TV
#import "DRActivityAlertView.h"
#import "DRLegacyLoadingHUD.h"
#endif

#import "UIDevice+Extensions.h"

typedef void(^completionHandler)(void);

#define minDisplayTimeSeconds 1.0f

@implementation DRLoadingHUD {
    DRLoadingHUDView *_loadingView;
    UIView *_dimmingView;
    CFAbsoluteTime _showTime;
}


+(instancetype) showHUDWithTitle: (NSString*) title
                    cancelButton: (NSString*) cancelText
               otherButtonTitles: (NSArray*) titles
                 callbackHandler: (DRLoadingHUDCallback) handler {
    DRLoadingHUD *hud;
    if ([UIDevice is_ios8]) {
        hud = [[self.class alloc] initWithTitle:title cancelButton:cancelText otherButtonTitles: titles callbackHandler:handler];
    } else {
#if !TARGET_OS_TV
        hud = [[DRLegacyLoadingHUD alloc] initWithTitle:title cancelButton:cancelText otherButtonTitles: titles callbackHandler:handler];
#endif
        
    }
    [hud show];
    return hud;
}

-(instancetype) initWithTitle: (NSString*) title
                 cancelButton: (NSString*) cancelText
            otherButtonTitles: (NSArray*) titles
              callbackHandler: (DRLoadingHUDCallback) handler {
    self  = [super init];
    if (self) {
        _loadingView = [[DRLoadingHUDView alloc] init];
        _loadingView.title = title;
        _loadingView.cancelText = cancelText;
        __weak id weakself = self;
        _loadingView.selectionBlock = ^(NSInteger buttonIndex) {
            [weakself cancelWithCompletionHandler:^{
                if (handler && weakself) {
                    handler(weakself,buttonIndex);
                }
            }];
        };
        _loadingView.otherButtonTitles = titles;
        [_loadingView loadView];
        _dimmingView = [[UIView alloc] initWithFrame:CGRectZero];
        _dimmingView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        
    }
    return self;
}

-(void) cancel {
    CFTimeInterval elapsed = CFAbsoluteTimeGetCurrent() - _showTime;
    
    if (elapsed < minDisplayTimeSeconds) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((minDisplayTimeSeconds-elapsed) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self cancelWithCompletionHandler:nil];
        });
    } else {
        [self cancelWithCompletionHandler:nil];
    }
    
}

-(void) cancelWithCompletionHandler: (completionHandler) handler {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    [UIView animateKeyframesWithDuration:0.4
                                   delay:0
                                 options:UIViewKeyframeAnimationOptionCalculationModeLinear
                              animations:^{
                                  [UIView addKeyframeWithRelativeStartTime:0
                                                          relativeDuration:0.8
                                                                animations:^{
                                                                    _loadingView.alpha = 0.0f;
                                                                    _loadingView.layer.transform = CATransform3DMakeScale(0.8, 0.8, 1);
                                                                }];
                                  [UIView addKeyframeWithRelativeStartTime:0.3
                                                          relativeDuration:0.5
                                                                animations:^{
                                                                    _dimmingView.alpha = 0.0f;
                                                                }];
    } completion:^(BOOL finished) {
        [_loadingView removeFromSuperview];
        [_dimmingView removeFromSuperview];
        if (handler) {
            handler();
        }
    }];
    
#endif
}

-(CGRect) getWindowBounds {
    return [[[UIApplication sharedApplication] keyWindow] bounds];
}

-(CGAffineTransform) getWindowTransform {
    return [[[UIApplication sharedApplication] keyWindow] transform];
}

-(void) show {
    _showTime = CFAbsoluteTimeGetCurrent() ;
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    _dimmingView.frame = _loadingView.frame = [self getWindowBounds];
    _dimmingView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _dimmingView.transform = _loadingView.transform = [self getWindowTransform];
    _loadingView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [_loadingView setNeedsLayout];
    _loadingView.alpha = 0.0f;
    _dimmingView.alpha = 0.0f;
    [window addSubview:_dimmingView];
    [window addSubview:_loadingView];
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    [UIView animateKeyframesWithDuration:0.4
                                   delay:0
                                 options:UIViewKeyframeAnimationOptionCalculationModeLinear
                              animations:^{
                                  [UIView addKeyframeWithRelativeStartTime:0
                                                          relativeDuration:0.5
                                                                animations:^{
                                                                    _dimmingView.alpha = 1.0f;
                                                                }];
                                  [UIView addKeyframeWithRelativeStartTime:0.3
                                                          relativeDuration:0.5
                                                                animations:^{
                                                                    _loadingView.alpha = 1.0f;
                                                                }];
                                  [UIView addKeyframeWithRelativeStartTime:0.3
                                                          relativeDuration:0.1
                                                                animations:^{
                                                                    _loadingView.layer.transform = CATransform3DMakeScale(1.1, 1.1, 1);
                                                                }];
                                  [UIView addKeyframeWithRelativeStartTime:0.4
                                                          relativeDuration:0.4
                                                                animations:^{
                                                                    _loadingView.layer.transform = CATransform3DMakeScale(0.99, 0.99, 1);
                                                                }];
                                  [UIView addKeyframeWithRelativeStartTime:0.8
                                                          relativeDuration:0.1
                                                                animations:^{
                                                                    _loadingView.layer.transform = CATransform3DIdentity;
                                                                }];
                              } completion:^(BOOL finished) {
                                  
                              }];
#endif
}

-(void) setTitle:(NSString *)title {
    _loadingView.title = title;
}

-(NSString*) title {
    return _loadingView.title;
}

@end
