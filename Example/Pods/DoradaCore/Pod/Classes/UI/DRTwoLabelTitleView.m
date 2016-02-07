//
//  RRTwoLabelTitleView.m
//  Dorada
//
//  Created by Daniel Broad on 27/06/2013.
//  Copyright (c) 2013 Dorada Software Ltd. All rights reserved.
//

#import "DRTwoLabelTitleView.h"

@implementation DRTwoLabelTitleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 0, 700, 36)];
    if (self) {

        // Initialization code
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 19)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        //_titleLabel.font = [[RRVisualTheme currentTheme] font_boldTitles];
        _titleLabel.backgroundColor = [UIColor clearColor];
        //_titleLabel.textColor = [[RRVisualTheme currentTheme] navigationBar_TextColor];
        [self addSubview:_titleLabel];
        
        self.subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 200, 14)];
        _subtitleLabel.textAlignment = NSTextAlignmentCenter;
        
        //_subtitleLabel.font = [[RRVisualTheme currentTheme] font_small];
        _subtitleLabel.backgroundColor = [UIColor clearColor];
        //_subtitleLabel.textColor = [[RRVisualTheme currentTheme] navigationBar_TextColor];
        _subtitleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
        [self addSubview:_subtitleLabel];
        
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return self;
}

-(void) setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self setNeedsLayout];
}

-(UINavigationBar*) myNavigationBar {
    UIView *view = self;
    while (view && ![view isKindOfClass:UINavigationBar.class]) {
        view = view.superview;
    }
    return (UINavigationBar*) view;
}

-(void) layoutSubviews {
    [super layoutSubviews];
    UINavigationBar *bar = [self myNavigationBar];
    
    CGPoint centerBar = CGPointMake(CGRectGetMidX(bar.bounds), CGRectGetMidY(bar.bounds)); // assumes nav bar is full width of screen - safe....
    CGPoint centerMe = [bar convertPoint:centerBar toView:self];
    
    [_subtitleLabel sizeToFit];
    [_titleLabel sizeToFit];
    
    
    BOOL shouldFitHorizontally = bar.frame.size.height < (_subtitleLabel.frame.size.height+_titleLabel.frame.size.height);
    
    if (![_subtitleLabel.text length]) {
        _titleLabel.center = CGPointMake(centerMe.x, floorf(CGRectGetMidY(bar.bounds)));
    } else {
        if (shouldFitHorizontally) {
            CGFloat d1 = _titleLabel.font.descender;
            CGFloat d2 = _subtitleLabel.font.descender;
            CGFloat d2Adjust = floorf(d1-d2)/2.0;
            CGFloat horizPadding = 5.0f;
            CGFloat maxSubtitleWidth = (self.bounds.size.width - self.titleLabel.bounds.size.width) / 2 - horizPadding*2;
            
            if (_subtitleLabel.frame.size.width > maxSubtitleWidth) {
                _subtitleLabel.frame = CGRectMake(_subtitleLabel.frame.origin.x, _subtitleLabel.frame.origin.y, maxSubtitleWidth, _subtitleLabel.frame.size.height);
            }
            _titleLabel.textAlignment = NSTextAlignmentCenter;
            _titleLabel.center = CGPointMake(centerMe.x, centerMe.y);
            _subtitleLabel.textAlignment = NSTextAlignmentCenter;
            _subtitleLabel.center = CGPointMake(centerMe.x+ceilf(_titleLabel.bounds.size.width/2)+ceilf(_subtitleLabel.bounds.size.width/2)+horizPadding, centerMe.y-d2Adjust);
        } else {
            _titleLabel.textAlignment = _subtitleLabel.textAlignment = NSTextAlignmentCenter;
            _titleLabel.center = CGPointMake(centerMe.x, floorf(centerMe.y-_titleLabel.bounds.size.height/2));
            _subtitleLabel.center = CGPointMake(centerMe.x, ceilf(centerMe.y+_subtitleLabel.bounds.size.height/2));
        }
    }


}

-(void) setTitle: (NSString*) title {
    self.titleLabel.text = title;
    [self setNeedsLayout];
}

-(void) setSubtitle: (NSString*) subtitle {
    self.subtitleLabel.text = subtitle;
    [self setNeedsLayout];
}
@end
