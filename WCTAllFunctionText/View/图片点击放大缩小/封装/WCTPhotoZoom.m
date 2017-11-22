//
//  WCTPhotoZoom.m
//  图片点击变大缩小
//
//  Created by four on 16/3/3.
//  Copyright © 2016年 four. All rights reserved.
//

#import "WCTPhotoZoom.h"

static CGRect oldframe;

@implementation WCTPhotoZoom

+(void)showImage:(UIImageView *)avatarImageView{
    
    UIImage *image=avatarImageView.image;
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    UIView *backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    oldframe=[avatarImageView convertRect:avatarImageView.bounds toView:window];
    
    backgroundView.backgroundColor=[UIColor blackColor];
    backgroundView.alpha=0;
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:oldframe];
    imageView.image=image;
    imageView.tag=1;
    [backgroundView addSubview:imageView];
    [window addSubview:backgroundView];
    
    UITapGestureRecognizer *twoFingersTwoTaps = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(twoFingersTwoTaps)];
    [twoFingersTwoTaps setNumberOfTapsRequired:2];
    [twoFingersTwoTaps setNumberOfTouchesRequired:1];
    [backgroundView addGestureRecognizer:twoFingersTwoTaps];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired  = 1;
    [backgroundView addGestureRecognizer:tap];
    
    [tap requireGestureRecognizerToFail:twoFingersTwoTaps];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        imageView.frame=CGRectMake(0,([UIScreen mainScreen].bounds.size.height-image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width)/2, [UIScreen mainScreen].bounds.size.width, image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width);
        backgroundView.alpha=1;
    } completion:^(BOOL finished) {
        
    }];
}

+ (void)twoFingersTwoTaps{
    NSLog(@"点击两次放缩");
}

+(void)hideImage:(UITapGestureRecognizer*)tap{
    UIView *backgroundView=tap.view;
    UIImageView *imageView=(UIImageView*)[tap.view viewWithTag:1];
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=oldframe;
        backgroundView.alpha=0;
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
    }];
}

@end
