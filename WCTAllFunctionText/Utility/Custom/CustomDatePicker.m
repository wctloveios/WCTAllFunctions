/*
 The MIT License (MIT)
 
 Copyright (c) 2013 SuXinDe (Email: suxinde2009@126.com)
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

#import "CustomDatePicker.h"
#import <QuartzCore/QuartzCore.h>

#define kSemiModalAnimationDuration 0.3f

@interface CustomDatePicker ()

- (void)_presentModelView;
- (void)_dismissModalView;

@end


@implementation CustomDatePicker

@synthesize delegate = _delegate;

- (id)init
{
    self = [super init];
    if (self) {
        
        CGSize size = [[UIScreen mainScreen] applicationFrame].size;
        self.frame = CGRectMake(0, 0, size.width, size.height/2.);
        //[self _initCommonUI:@"请选择日期" DateModel:dModel];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame DateModel:(UIDatePickerMode)dModel WithBirthday:(BOOL)birth {
    if(self = [super initWithFrame:frame]){
        _originalSize = CGSizeMake(frame.size.width, frame.size.height);
        [self _initCommonBirtgdatUI:@"出生日期" DateModel:dModel];
    }
    return self;
}

- (void)_initCommonBirtgdatUI:(NSString *)title DateModel:(UIDatePickerMode)dModel
{
    _halfOriginalSize = CGSizeMake(_originalSize.width, _originalSize.height/2.0f);
    
    self.backgroundColor = [UIColor clearColor];
    
    UIView *helpView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, 240)];
    helpView.backgroundColor = [UIColor whiteColor];
    helpView.layer.cornerRadius = 5;
    [self addSubview:helpView];
    
    pickView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, 240)];
    pickView.backgroundColor = [UIColor whiteColor];
    pickView.datePickerMode = dModel;
    [helpView addSubview:pickView];
    
    if (dModel == UIDatePickerModeDate) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        NSDate *minDate = [dateFormatter dateFromString:@"1940-01-01"];
        
        pickView.minimumDate = minDate;
        pickView.maximumDate = [NSDate date];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame: CGRectMake((MainScreenWidth-(MainScreenWidth/3))/2, 5, MainScreenWidth/3, 35)];
        titleLabel.font = [UIFont systemFontOfSize:20 ];
        titleLabel.backgroundColor = [UIColor whiteColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = title;
        //[helpView addSubview: titleLabel];
        
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBtn.tag = 2000;
        leftBtn.frame = CGRectMake(5, 5, 70, 35);
        leftBtn.backgroundColor = [UIColor whiteColor];
        [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
        [leftBtn setTitleColor:RGB(89, 207, 193) forState: UIControlStateNormal];
        [leftBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:20 ]];
        [leftBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        leftBtn.layer.cornerRadius = 5;
        leftBtn.tag = 1110;
        [helpView addSubview:leftBtn];
        
        
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.tag = 2001;
        rightBtn.frame = CGRectMake(MainScreenWidth -70 , 5, 70, 35);
        rightBtn.backgroundColor = [UIColor whiteColor];
        [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
        [rightBtn setTitleColor:RGB(89, 207, 193) forState: UIControlStateNormal];
        [rightBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:20 ]];
        [rightBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        rightBtn.layer.cornerRadius = 5;
        rightBtn.tag = 1111;
        [helpView addSubview:rightBtn];
    }
    else if (dModel == UIDatePickerModeTime) {
        [pickView addTarget:self action:@selector(dateValuesChanged:) forControlEvents:UIControlEventValueChanged];
    }
}

- (id)initWithFrame:(CGRect)frame DateModel:(UIDatePickerMode)dModel IsLimit:(BOOL)limit
{
    if(self = [super initWithFrame:frame]){
        _originalSize = CGSizeMake(frame.size.width, frame.size.height);
        [self _initCommonUI:@"请选择日期" DateModel:dModel Limit:limit];
    }
    return self;
}

- (void)_initCommonUI:(NSString *)title DateModel:(UIDatePickerMode)dModel Limit:(BOOL)limit
{
    _halfOriginalSize = CGSizeMake(_originalSize.width, _originalSize.height/2.0f);
    
    self.backgroundColor = [UIColor clearColor];

    UIView *helpView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, 240)];
    helpView.backgroundColor = [UIColor whiteColor];
    helpView.layer.cornerRadius = 5;
    [self addSubview:helpView];
    
    pickView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, 240)];
    pickView.backgroundColor = [UIColor whiteColor];
    pickView.datePickerMode = dModel;
    [helpView addSubview:pickView];
    
    if (dModel == UIDatePickerModeDate) {
        if (limit) {
            pickView.maximumDate = [NSDate date];
        }
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame: CGRectMake((MainScreenWidth-(MainScreenWidth/3))/2, 5, MainScreenWidth/3, 35)];
        titleLabel.font = [UIFont systemFontOfSize:20 ];
        titleLabel.backgroundColor = [UIColor whiteColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = title;
        //[helpView addSubview: titleLabel];
        
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBtn.tag = 2000;
        leftBtn.frame = CGRectMake(5, 5, 70, 35);
        leftBtn.backgroundColor = [UIColor whiteColor];
        [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
        [leftBtn setTitleColor:RGB(89, 207, 193) forState: UIControlStateNormal];
        [leftBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:20 ]];
        [leftBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        leftBtn.layer.cornerRadius = 5;
        leftBtn.tag = 1110;
        [helpView addSubview:leftBtn];
        
        
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.tag = 2001;
        rightBtn.frame = CGRectMake(MainScreenWidth -70 , 5, 70, 35);
        rightBtn.backgroundColor = [UIColor whiteColor];
        [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
        [rightBtn setTitleColor:RGB(89, 207, 193) forState: UIControlStateNormal];
        [rightBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:20 ]];
        [rightBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        rightBtn.layer.cornerRadius = 5;
        rightBtn.tag = 1111;
        [helpView addSubview:rightBtn];
    }
    else if (dModel == UIDatePickerModeTime) {
        [pickView addTarget:self action:@selector(dateValuesChanged:) forControlEvents:UIControlEventValueChanged];
    }
}

- (void)show
{
    if (isPresent) {
        return;
    }
    [self _presentModelView];
}

- (void)dismiss
{
    [self _dismissModalView];
}


- (void)_presentModelView
{
    if (isPresent) {
        return;
    }
    UIWindow *keywindow = [[UIApplication sharedApplication] keyWindow];
    if (![keywindow.subviews containsObject:self] ) {

        CGRect sf = self.frame;
        CGRect vf = keywindow.frame;
        CGRect f  = CGRectMake(0, vf.size.height-sf.size.height, vf.size.width, sf.size.height);
        CGRect of = CGRectMake(0, 0, vf.size.width, vf.size.height-sf.size.height);
        NSStringFromCGRect(f);
        NSStringFromCGRect(of);
        UIView * overlay = [[UIView alloc] initWithFrame:keywindow.bounds];
        UIView* ss = [[UIView alloc] initWithFrame:keywindow.bounds];
        [overlay addSubview:ss];
        [keywindow addSubview:overlay];
        UIControl * dismissButton = [[UIControl alloc] initWithFrame:CGRectZero];
        [dismissButton addTarget:self action:@selector(_dismissModalView) forControlEvents:UIControlEventTouchUpInside];
        dismissButton.backgroundColor = [UIColor clearColor];
        dismissButton.frame = of;
        [overlay addSubview:dismissButton];
        
        self.frame = CGRectMake(0, vf.size.height, vf.size.width, sf.size.height);
        [keywindow addSubview:self];
        
        [UIView animateKeyframesWithDuration:kSemiModalAnimationDuration delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
            overlay.backgroundColor = [UIColor clearColor];
            overlay.backgroundColor = [UIColor blackColor];
            overlay.alpha = 0.4;
            self.frame = f;
        } completion:^(BOOL finished){
            isPresent = NO;
            
        }];
        
        
//        [UIView animateWithDuration:kSemiModalAnimationDuration animations:^{
//            overlay.backgroundColor = [UIColor clearColor];
//            overlay.backgroundColor = [UIColor blackColor];
//            overlay.alpha = 0.4;
//            self.frame = f;
//            isPresent = YES;
//        }];
    }

}

- (void)_dismissModalView
{
    UIWindow * keywindow = [[UIApplication sharedApplication] keyWindow];
    UIView * modal = [keywindow.subviews objectAtIndex:keywindow.subviews.count-1];
    UIView * overlay = [keywindow.subviews objectAtIndex:keywindow.subviews.count-2];
    [UIView animateWithDuration:kSemiModalAnimationDuration animations:^{
        modal.frame = CGRectMake(0, keywindow.frame.size.height, modal.frame.size.width, modal.frame.size.height);
        overlay.backgroundColor = [UIColor blackColor];
        overlay.backgroundColor = [UIColor clearColor];
        overlay.alpha = 1;
    } completion:^(BOOL finished) {
        [overlay removeFromSuperview];
        [modal removeFromSuperview];
        //isPresent = NO;
    }];
    
}

-(void)clickAction:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if (_delegate && [_delegate conformsToProtocol:@protocol(CustomDatePickerDelegate)])
    {
        if (button.tag == 1111) {
            if ([_delegate respondsToSelector:@selector(CustomDatePickerFromDate:)]) {
                NSDate *curDate = pickView.date;
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                
                NSString *stringDate = [formatter stringFromDate:curDate];
                
                [_delegate CustomDatePickerFromDate:stringDate];
            }
        }
    }
    [self dismiss];
}

- (void) dateValuesChanged:(id)sender {
    if ([_delegate respondsToSelector:@selector(CustomDatePicker:)]) {
        NSDate *curDate = pickView.date;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HH:mm"];
        
        NSString *stringDate = [formatter stringFromDate:curDate];
        
        [_delegate CustomDatePicker:stringDate];
    }
    
    /*if ([_delegate respondsToSelector:@selector(CustomDatePickerFromDate:)]) {
        NSDate *curDate = pickView.date;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        
        NSString *stringDate = [formatter stringFromDate:curDate];
        
        [_delegate CustomDatePickerFromDate:stringDate];
    }*/
}

- (void)dealloc
{
    _delegate = nil;
}

@end

