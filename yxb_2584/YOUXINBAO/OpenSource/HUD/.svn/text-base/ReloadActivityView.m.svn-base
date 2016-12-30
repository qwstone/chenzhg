//
//  ReloadActivityView.m
//
//  Created by Joy Chiang on 11-9-18.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ReloadActivityView.h"
#import <QuartzCore/QuartzCore.h>

@implementation ReloadActivityView

@synthesize hidesWhenStopped = _hidesWhenStopped;
@synthesize animationDuration =_animationDuration;

- (id)init {
    if ((self = [super initWithFrame:CGRectMake(0, 0, 28, 28)])) {
        self.hidesWhenStopped = YES;
        self.showsTouchWhenHighlighted = YES;
        [self setBackgroundImage:[UIImage imageNamed:@"reload"] forState:UIControlStateNormal];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.hidesWhenStopped = YES;
        self.showsTouchWhenHighlighted = YES;
        [self setBackgroundImage:[UIImage imageNamed:@"reload"] forState:UIControlStateNormal];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        self.hidesWhenStopped = YES;
        self.showsTouchWhenHighlighted = YES;
        [self setBackgroundImage:[UIImage imageNamed:@"reload"] forState:UIControlStateNormal];
    }
    return self;
}

- (BOOL)isAnimating {
    CAAnimation *spinAnimation = [self.layer animationForKey:@"spinAnimation"];
    return (_animating || spinAnimation);
}

- (void)startAnimating {
    if (!_animating) {
        self.hidden = NO;
        _animating = YES;
        [self spin];
    }
}

- (void)stopAnimating {
    _animating = NO;
    self.hidden = _hidesWhenStopped;
}

- (void)spin {
    CABasicAnimation *spinAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    spinAnimation.byValue = [NSNumber numberWithFloat:2*M_PI];
    spinAnimation.duration = self.animationDuration;
//    spinAnimation.delegate = self;
    spinAnimation.repeatCount = MAXFLOAT;
    spinAnimation.removedOnCompletion = NO;
    [self.layer addAnimation:spinAnimation forKey:@"spinAnimation"];
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag {
//    if (_animating) {
//        [self spin];
//    }
}

- (CGFloat)animationDuration {
    if (!_animationDuration) {
        _animationDuration = 1.0f;
    }
    return _animationDuration;
}

- (void)dealloc {
    [self.layer removeAllAnimations];
    
    [super dealloc];
}

@end