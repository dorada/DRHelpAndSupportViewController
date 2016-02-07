//
//  DRLoadingHUDView.m
//  DoradaCore
//
//  Created by Daniel Broad on 18/06/2014.
//  Copyright (c) 2014 Dorada. All rights reserved.
//

#import "DRLoadingHUDView.h"
#import "DRSeparatorView.h"
#import "NSString+OS7.h"
#import <QuartzCore/QuartzCore.h>

@implementation DRLoadingHUDView {
    
    UILabel *_titleLabel;
    CGFloat _textHeight;
    UIActivityIndicatorView *_activityIndicatorView;
    NSMutableArray *_separatorViews;
    UIButton *_cancelButton;
    NSMutableArray *_otherButtons;
    
    UIView *_visualEffectView;
}


-(instancetype) init {
    self = [super init];
    if (self) {
    }
    return self;
}

const CGFloat boxWidth = 270;

-(void) loadView {
    self.backgroundColor = [UIColor clearColor];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
    _visualEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
#else
    _visualEffectView = [[UIView alloc] initWithFrame:CGRectZero];
    _visualEffectView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.9];
#endif
    _visualEffectView.layer.cornerRadius = 7.0f;
    _visualEffectView.clipsToBounds = YES;
    [self addSubview:_visualEffectView];
#if !TARGET_OS_TV
    _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
#else
    _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
#endif
    
    [_activityIndicatorView startAnimating];
    //_activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self addSubview:_activityIndicatorView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.text = self.title;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
    _titleLabel.numberOfLines = 0;
    _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self addSubview:_titleLabel];
    
    _textHeight = ceilf([self.title drsizeWithFont:_titleLabel.font constrainedToSize:CGSizeMake(boxWidth, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping].height);
    
    _cancelButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [_cancelButton setTitle:self.cancelText forState:UIControlStateNormal];
    [_cancelButton addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_cancelButton];
    
    if (self.cancelText) {
        _separatorViews = [NSMutableArray array];
        DRSeparatorView *_separatorView = [[DRSeparatorView alloc] initWithFrame:CGRectZero];
        [self addSubview:_separatorView];
        [_separatorViews addObject:_separatorView];
    }

    _otherButtons = [NSMutableArray array];
    for (NSString *title in _otherButtonTitles) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
        [button setTitle:title forState:UIControlStateNormal];
        [self addSubview:button];
        [_otherButtons addObject:button];
        button.tag = [_otherButtons count];
        [button addTarget:self action:@selector(otherButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        DRSeparatorView *_separatorView = [[DRSeparatorView alloc] initWithFrame:CGRectZero];
        [self addSubview:_separatorView];
        [_separatorViews addObject:_separatorView];
    }
}

-(void) layoutSubviews {
    
    CGFloat buttonHeight = 44.0f;
    CGFloat boxHeight = buttonHeight+(buttonHeight*[_otherButtonTitles count])+56.0+_textHeight;
    
    if (!self.cancelText) {
        boxHeight = boxHeight-buttonHeight;
        //_separatorView.hidden = YES;
    } else {
        //_separatorView.hidden = NO;
    }
    
    CGFloat height = self.frame.size.height;
    CGFloat width = self.frame.size.width;
    
    CGFloat boxLeft = (width-boxWidth)/2;
    CGFloat boxTop = (height-boxHeight)/2;
    
    _visualEffectView.frame = CGRectMake(boxLeft, boxTop, boxWidth, boxHeight);
    
    if (_textHeight) {
        _titleLabel.frame = CGRectMake(boxLeft, _visualEffectView.frame.origin.y+8.0f, boxWidth, _textHeight);
    } else {
        _titleLabel.frame = CGRectMake(boxLeft, _visualEffectView.frame.origin.y, boxWidth, _textHeight); // no text ensure its at the top zero zero
    }
    
    CGFloat buttonsTop = boxTop+boxHeight-buttonHeight-(buttonHeight*[_otherButtons count]);
    if (!self.cancelText) {
        buttonsTop+=buttonHeight;
    }
    CGFloat activityTop = CGRectGetMaxY(_titleLabel.frame);
    activityTop += (buttonsTop-activityTop-_activityIndicatorView.frame.size.height)/2;
    _activityIndicatorView.frame = CGRectMake((width-_activityIndicatorView.frame.size.width)/2,floorf(activityTop), _activityIndicatorView.frame.size.width, _activityIndicatorView.frame.size.height);
    
    
    CGFloat currentY = buttonsTop;
    NSInteger separator = 0;
    for (UIButton *button in _otherButtons) {
        DRSeparatorView *_separatorView = [_separatorViews objectAtIndex:separator];
        _separatorView.frame = CGRectMake(boxLeft, currentY-2.0f, boxWidth, 2);
        [self bringSubviewToFront:_separatorView];
        [button setTitleColor:self.tintColor forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        button.frame = CGRectMake(boxLeft, currentY, boxWidth, buttonHeight);
        currentY+=buttonHeight;
        separator++;
    }
    
    [_cancelButton setTitleColor:self.tintColor forState:UIControlStateNormal];
    _cancelButton.frame = CGRectMake(boxLeft, currentY, boxWidth, buttonHeight);
    DRSeparatorView *_separatorView = [_separatorViews objectAtIndex:separator];
    _separatorView.frame = CGRectMake(boxLeft, currentY-2.0f, boxWidth, 2);
    [self bringSubviewToFront:_separatorView];
}

-(void) cancelButtonPressed: (UIButton*) sender {
    self.selectionBlock(0);
}

-(void) otherButtonPressed: (UIButton*) sender {
    self.selectionBlock(sender.tag);
}

-(void) setTitle:(NSString *)title {
    _title = title;
    if (_titleLabel) {
        _titleLabel.text = title;
        _textHeight = ceilf([self.title drsizeWithFont:_titleLabel.font constrainedToSize:CGSizeMake(boxWidth, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping].height);
        [self setNeedsLayout];
    }
}

-(void) setCancelText:(NSString *)cancelText {
    _cancelText = cancelText;
    [self setNeedsLayout];
}

@end
