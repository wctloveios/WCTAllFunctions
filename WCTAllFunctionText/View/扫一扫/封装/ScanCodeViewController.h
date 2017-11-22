//
//  ScanCodeViewController.h
//  WCTAllFunctionText
//
//  Created by four on 16/3/23.
//  Copyright © 2016年 王春涛. All rights reserved.
//

#import "AlphaImageView.h"
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

@interface ScanCodeViewController : UIViewController
{
    int num;
    BOOL upOrdown;
    NSTimer *timer;
}

@property (nonatomic, strong) UIImageView * imgViewScanLine;
@property (nonatomic, strong) AlphaImageView *alphaImgView;
@property (nonatomic, retain) UIImageView * line;
@end
