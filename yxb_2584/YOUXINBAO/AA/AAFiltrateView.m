//
//  AAFiltrateView.m
//  YOUXINBAO
//
//  Created by CH10 on 15/3/6.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "AAFiltrateView.h"

@implementation AAFiltrateView {
    NSArray *_typeArray;
    NSArray *_timeArray;
    NSArray *_mineArray;
    NSArray *_costArray;
    NSArray *_activityArray;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    _typeArray = [NSArray arrayWithObjects:_typeAll,_typeEat,_typeKTV,_typeSports,_typeFriend,_typeStudy,_typeTravel,_typeElse, nil];
    _timeArray = [NSArray arrayWithObjects:_timeAll,_timeToday,_timeTomorrow,_timeWeekend, nil];
    _mineArray = [NSArray arrayWithObjects:_mineAll,_mineParticipate,_mineInvite,_mineLaunch,_berefuse, nil];
    _costArray = [NSArray arrayWithObjects:_costAll,_costExpend,_costFree, nil];
    _activityArray = [NSArray arrayWithObjects:_activityCanceled,_activityFinished,_activityPassed,_activityStarted,_activityAll, nil];
    
    _nearbyView.layer.cornerRadius = 6;
    _nearbyView.layer.masksToBounds = YES;
    _mineView.layer.cornerRadius = 6;
    _mineView.layer.masksToBounds = YES;
    
//    [self changeSelected:_typeAll inArray:_typeArray];
    self.type = filtrateTypeAll;
//    [self changeSelected:_timeAll inArray:_timeArray];
    self.time = filtrateTimeAll;
//    [self changeSelected:_mineAll inArray:_mineArray];
    self.mine = FilterMyCategoryAll;
//    [self changeSelected:_costAll inArray:_costArray];
    self.cost = filtrateCostAll;
//    [self changeSelected:_activityAll inArray:_activityArray];
//    self.type = filtrateTypeAll;
    self.text = @"";
    
    [self sendSubviewToBack:_backView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenTap:)];
    [_backView addGestureRecognizer:tap];
}

- (void)setType:(FiltrateType)type {
    _type = type;
    [self changeSelected:[self getButtonWithType:type] inArray:_typeArray];
}

- (QCFiltrateButton *)getButtonWithType:(FiltrateType)type {
    QCFiltrateButton *button = nil;
    if (type == filtrateTypeAll) {
        if (_mineView.hidden) {
            button = _typeAll;
        }else {
            button = _activityAll;
        }
    }else if (type == filtrateTypeEat) {
        button = _typeEat;
    }else if (type == filtrateTypeKTV) {
        button = _typeKTV;
    }else if (type == filtrateTypeSports) {
        button = _typeSports;
    }else if (type == filtrateTypeFriend) {
        button = _typeFriend;
    }else if (type == filtrateTypeStudy) {
        button = _typeStudy;
    }else if (type == filtrateTypeTravel) {
        button = _typeTravel;
    }else if (type == filtrateTypeElse) {
        button = _typeElse;
    }else if (type == filtrateTypeStarted) {
        button = _activityStarted;
    }else if (type == filtrateTypePassed) {
        button = _activityPassed;
    }else if (type == filtrateTypeCanceled) {
        button = _activityCanceled;
    }else if (type == filtrateTypeFinished) {
        button = _activityFinished;
    }
    return button;
}

- (IBAction)typeAll:(UIButton *)sender {
//    [self changeSelected:_typeAll inArray:_typeArray];
    self.type = filtrateTypeAll;
}
- (IBAction)typeEat:(id)sender {
//    [self changeSelected:_typeEat inArray:_typeArray];
    self.type = filtrateTypeEat;
}
- (IBAction)typeKTV:(id)sender {
//    [self changeSelected:_typeKTV inArray:_typeArray];
    self.type = filtrateTypeKTV;
}
- (IBAction)typeSports:(id)sender {
//    [self changeSelected:_typeSports inArray:_typeArray];
    self.type = filtrateTypeSports;
}
- (IBAction)typeFriend:(id)sender {
//    [self changeSelected:_typeFriend inArray:_typeArray];
    self.type = filtrateTypeFriend;
}
- (IBAction)typeStudy:(id)sender {
//    [self changeSelected:_typeStudy inArray:_typeArray];
    self.type = filtrateTypeStudy;
}
- (IBAction)typeTravel:(id)sender {
//    [self changeSelected:_typeTravel inArray:_typeArray];
    self.type = filtrateTypeTravel;
}
- (IBAction)typeElse:(id)sender {
//    [self changeSelected:_typeElse inArray:_typeArray];
    self.type = filtrateTypeElse;
}
- (IBAction)timeAll:(id)sender {
    [self changeSelected:_timeAll inArray:_timeArray];
    self.time = filtrateTimeAll;
}
- (IBAction)timeToday:(id)sender {
    [self changeSelected:_timeToday inArray:_timeArray];
    self.time = filtrateTimeToday;
}
- (IBAction)timeTomorrow:(id)sender {
    [self changeSelected:_timeTomorrow inArray:_timeArray];
    self.time = filtrateTimeTomorrow;
}
- (IBAction)timeWeekend:(id)sender {
    [self changeSelected:_timeWeekend inArray:_timeArray];
    self.time = filtrateTimeWeekend;
}
- (IBAction)mineAll:(id)sender {
    [self changeSelected:_mineAll inArray:_mineArray];
    self.mine = FilterMyCategoryAll;
}
- (IBAction)mineParticipate:(id)sender {
    [self changeSelected:_mineParticipate inArray:_mineArray];
    self.mine = FilterMyCategoryJoined;
}
- (IBAction)mineInvite:(id)sender {
    [self changeSelected:_mineInvite inArray:_mineArray];
    self.mine = FilterMyCategoryBeinvited;
}
- (IBAction)mineLaunch:(id)sender {
    [self changeSelected:_mineLaunch inArray:_mineArray];
    self.mine = FilterMyCategoryCreated;
}
- (IBAction)mineBerefuse:(id)sender {
    [self changeSelected:_berefuse inArray:_mineArray];
    self.mine = FilterMyCategoryRejected;
}

- (IBAction)sureButton:(UIButton *)sender {
//    self.hidden = YES;
    [self removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(sureButtonDidTouch:)]) {
        [self.delegate sureButtonDidTouch:self];
        
    }
}
- (IBAction)mineSureButton:(UIButton *)sender {
//    self.hidden = YES;
    [self removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(sureButtonDidTouch:)]) {
        [self.delegate sureButtonDidTouch:self];
    }
}
- (IBAction)costAll:(id)sender {
    [self changeSelected:_costAll inArray:_costArray];
    self.cost = filtrateCostAll;
}
- (IBAction)costExpend:(id)sender {
    [self changeSelected:_costExpend inArray:_costArray];
    self.cost = filtrateCostExpend;
}
- (IBAction)costFree:(id)sender {
    [self changeSelected:_costFree inArray:_costArray];
    self.cost = filtrateCostFree;
}
- (IBAction)activityChecking:(id)sender {
//    [self changeSelected:_activityChecking inArray:_activityArray];
    self.type = filtrateTypeChecking;
}
- (IBAction)activityStarted:(id)sender {
//    [self changeSelected:_activityStarted inArray:_activityArray];
    self.type = filtrateTypeStarted;
}
- (IBAction)activityPassed:(id)sender {
//    [self changeSelected:_activityPassed inArray:_activityArray];
    self.type = filtrateTypePassed;
}
- (IBAction)activityFailed:(id)sender {
//    [self changeSelected:_activityRejected inArray:_activityArray];
    self.type = filtrateTypeRejected;
}
- (IBAction)activityAll:(id)sender {
//    [self changeSelected:_activityAll inArray:_activityArray];
    self.type = filtrateTypeAll;
}
- (IBAction)activityCanceled:(id)sender {
//    [self changeSelected:_activityCanceled inArray:_activityArray];
    self.type = filtrateTypeCanceled;
}
- (IBAction)activityFinished:(id)sender {
//    [self changeSelected:_activityFinished inArray:_activityArray];
    self.type = filtrateTypeFinished;
}



- (IBAction)hiddenTap:(id)sender {
//    self.hidden =  YES;
    [self removeFromSuperview];
}
//
//- (void)setHidden:(BOOL)hidden {
//    [super setHidden:hidden];
////    _textField.text = nil;
//    //初始化
//    if (!hidden) {
////        self.type = filtrateTypeAll;
////        self.time = filtrateTimeAll;
////        self.mine = FilterMyCategoryAll;
////        self.cost = filtrateCostAll;
////        [self changeSelected:_typeAll inArray:_typeArray];
////        self.type = filtrateTypeAll;
////        [self changeSelected:_timeAll inArray:_timeArray];
////        self.time = filtrateTimeAll;
////        [self changeSelected:_mineAll inArray:_mineArray];
////        self.mine = FilterMyCategoryAll;
////        [self changeSelected:_costAll inArray:_costArray];
////        self.cost = filtrateCostAll;
////        [self changeSelected:_activityAll inArray:_activityArray];
////        self.type = filtrateTypeAll;
////        self.text = @"";
//        
//    }
//}

- (void)changeSelected:(UIButton *)button inArray:(NSArray *)array {
    for (UIButton *elseButton in array) {
        elseButton.selected = NO;
    }
    button.selected = YES;
}

#pragma mark - UITextField delegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.text == nil) {
        self.text = @"";
    }else {
        self.text = textField.text;
//        textField.text = nil;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
