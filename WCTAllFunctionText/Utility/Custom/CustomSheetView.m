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

#import "CustomSheetView.h"
#import <QuartzCore/QuartzCore.h>

#define kSemiModalAnimationDuration 0.3f

@interface CustomSheetView () {
    NSMutableArray *aryDataSources;
}

- (void)_initCommonUI;
- (void)_presentModelView;
- (void)_dismissModalView;

@end


@implementation CustomSheetView

- (id)init
{
    self = [super init];
    if (self) {
        
        CGSize size = [[UIScreen mainScreen] applicationFrame].size;
        self.frame = CGRectMake(0, 0, size.width, size.height/2.);
        [self _initCommonUI];
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        _originalSize = CGSizeMake(frame.size.width, frame.size.height);
        [self _initCommonUI];
    }
    return self;
}

- (id) initWithFrame:(CGRect)frame DataSources:(NSMutableArray *)arySources {
    if(self = [super initWithFrame:frame]){
        aryDataSources = arySources;
        
        [self _initCommonUI];
    }
    return self;
}

- (void)_initCommonUI
{
    _halfOriginalSize = CGSizeMake(_originalSize.width, _originalSize.height/2.0f);
    
    self.backgroundColor = [UIColor clearColor];

    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, self.frame.size.height)];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.layer.cornerRadius = 5;
    [self addSubview:contentView];
    
    for (int n = 0; n < [aryDataSources count]; n++) {
        NSDictionary *dct = [aryDataSources objectAtIndex:n];
        
        UIView *viewSubContent = [[UIView alloc] initWithFrame:CGRectMake(0, 54 * n, contentView.frame.size.width, 54)];
        viewSubContent.backgroundColor = [UIColor clearColor];
        [contentView addSubview:viewSubContent];
        
        UIImageView *imgViewIcon = [[UIImageView alloc] initWithFrame:CGRectMake(15, (viewSubContent.frame.size.height - 20) / 2.0, 20, 20)];
        imgViewIcon.backgroundColor = [UIColor clearColor];
        imgViewIcon.image = [UIImage imageNamed:[dct objectForKey:@"IconName"]];
        [viewSubContent addSubview:imgViewIcon];
        
        CustomLabel *lblTitle = [[CustomLabel alloc] initWithFrame:CGRectMake(imgViewIcon.frame.size.width + imgViewIcon.frame.origin.x + 15, 0, viewSubContent.frame.size.width - (imgViewIcon.frame.size.width + imgViewIcon.frame.origin.x + 15), viewSubContent.frame.size.height) BackgroundColor:[UIColor clearColor] Font:[UIFont systemFontOfSize:15.0 ] TextColor:RGB(91, 91, 91) Alignment:NSTextAlignmentLeft Text:[dct objectForKey:@"ButtonTitle"]];
        [viewSubContent addSubview:lblTitle];
        
        // 初始化更多按钮
        CustomButton *btnCovert = [CustomButton buttonWithType:UIButtonTypeCustom];
        btnCovert.tag = 110011 + n;
        btnCovert.backgroundColor = [UIColor clearColor];
        btnCovert.frame = CGRectMake(0, 0, viewSubContent.frame.size.width, 54);
        [btnCovert addTarget:self action:@selector(btnCovertAction:) forControlEvents:UIControlEventTouchUpInside];
        [viewSubContent addSubview:btnCovert];
        
        if (n != [aryDataSources count] - 1) {
            UIImageView *imgViewLine = [[UIImageView alloc] initWithFrame:CGRectMake(15, viewSubContent.frame.size.height - 1, viewSubContent.frame.size.width - 30, 1)];
            imgViewLine.backgroundColor = RGB(91, 91, 91);
            [viewSubContent addSubview:imgViewLine];
        }
    }
}

- (id) initActionSheetWithFrame:(CGRect)frame DataSources:(NSMutableArray *)arySources {
    if(self = [super initWithFrame:frame]){
        aryDataSources = arySources;
        
        [self _initCommonSheetUI];
    }
    return self;
}

- (void)_initCommonSheetUI
{
    _halfOriginalSize = CGSizeMake(_originalSize.width, _originalSize.height/2.0f);
    
    self.backgroundColor = [UIColor clearColor];
    
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, self.frame.size.height)];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.layer.cornerRadius = 5;
    [self addSubview:contentView];
    
    for (int n = 0; n < [aryDataSources count]; n++) {
        NSDictionary *dct = [aryDataSources objectAtIndex:n];
        
        UIView *viewSubContent = [[UIView alloc] initWithFrame:CGRectMake(0, 54 * n, contentView.frame.size.width, 54)];
        viewSubContent.backgroundColor = [UIColor clearColor];
        [contentView addSubview:viewSubContent];
        
        UIImageView *imgViewIcon = [[UIImageView alloc] initWithFrame:CGRectMake(15, (viewSubContent.frame.size.height - 20) / 2.0, 20, 20)];
        imgViewIcon.backgroundColor = [UIColor clearColor];
        imgViewIcon.image = [UIImage imageNamed:[dct objectForKey:@"IconName"]];
        [viewSubContent addSubview:imgViewIcon];
        
        CustomLabel *lblTitle = [[CustomLabel alloc] initWithFrame:CGRectMake(0, 0, viewSubContent.frame.size.width, viewSubContent.frame.size.height) BackgroundColor:[UIColor clearColor] Font:[UIFont systemFontOfSize:15.0 ] TextColor:RGB(91, 91, 91) Alignment:NSTextAlignmentCenter Text:[dct objectForKey:@"ButtonTitle"]];
        [viewSubContent addSubview:lblTitle];
        
        // 初始化更多按钮
        CustomButton *btnCovert = [CustomButton buttonWithType:UIButtonTypeCustom];
        btnCovert.tag = 210011 + n;
        btnCovert.backgroundColor = [UIColor clearColor];
        btnCovert.frame = CGRectMake(0, 0, viewSubContent.frame.size.width, 54);
        [btnCovert addTarget:self action:@selector(btnCovertAction:) forControlEvents:UIControlEventTouchUpInside];
        [viewSubContent addSubview:btnCovert];
        
        if (n != [aryDataSources count] - 1) {
            UIImageView *imgViewLine = [[UIImageView alloc] initWithFrame:CGRectMake(15, viewSubContent.frame.size.height - 1, viewSubContent.frame.size.width - 30, 1)];
            imgViewLine.backgroundColor = RGB(238, 238, 238);
            [viewSubContent addSubview:imgViewLine];
            lblTitle.textColor = RGB(91, 91, 91);
        }
        else {
            lblTitle.textColor = [UIColor redColor];
        }
    }
}

- (void) btnCovertAction:(CustomButton *)sender {
    if (self.sheetPopViewBlock) {
        self.sheetPopViewBlock(sender);
        
        [self dismiss];
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
    }

}

- (void)_dismissModalView
{
    UIWindow * keywindow = [[UIApplication sharedApplication] keyWindow];
    if (keywindow.subviews.count-1 < [keywindow.subviews count]) {
        UIView * modal = [keywindow.subviews objectAtIndex:keywindow.subviews.count-1];
        if (keywindow.subviews.count-2 < [keywindow.subviews count]) {
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
    }
}

- (void)dealloc
{
    
}

@end

