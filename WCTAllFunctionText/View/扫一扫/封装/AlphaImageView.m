//
//  AlphaImageView.m
//  MobileOffice_iphone
//
//  Created by Sgs on 14-9-22.
//  Copyright (c) 2014年 coson. All rights reserved.
//

#import "AlphaImageView.h"

#define kCropRect_Width 220
#define kCropRect_Height 219

#define kCropRect_X (([UIScreen mainScreen].bounds.size.width - kCropRect_Width) / 2)
#define kCropRect_Y 100

#define kRGB_Value (0 / 255.0)

@implementation AlphaImageView

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect cropArea = CGRectMake(([UIScreen mainScreen].bounds.size.width - kCropRect_Width) / 2.0 ,153, kCropRect_Width, kCropRect_Height);//坐标
    CGContextSetRGBFillColor(context, 1, 1, 1, 0);//颜色（RGB）,透明度
    CGContextFillRect(context, cropArea);
    
    if ([UIScreen mainScreen].bounds.size.height == 480) {
        cropArea = CGRectMake(cropArea.origin.x, 124, cropArea.size.width, cropArea.size.height);
    }
    
    CGRect rectArea_A = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, cropArea.origin.y);
    CGContextSetRGBFillColor(context, kRGB_Value, kRGB_Value, kRGB_Value, 1);//颜色（RGB）,透明度
    CGContextFillRect(context, rectArea_A);
    
    CGRect rectArea_B = CGRectMake(0, rectArea_A.size.height, cropArea.origin.x, cropArea.size.height);
    CGContextSetRGBFillColor(context, kRGB_Value, kRGB_Value, kRGB_Value, 1);//颜色（RGB）,透明度
    CGContextFillRect(context, rectArea_B);
    
    CGRect rectArea_C = CGRectMake(cropArea.origin.x + cropArea.size.width, rectArea_B.origin.y, rectArea_B.size.width, cropArea.size.height);
    CGContextSetRGBFillColor(context, kRGB_Value, kRGB_Value, kRGB_Value, 1);//颜色（RGB）,透明度
    CGContextFillRect(context, rectArea_C);
    
    CGRect rectArea_D = CGRectMake(0, cropArea.origin.y + cropArea.size.height, rectArea_A.size.width, [UIScreen mainScreen].bounds.size.height - (cropArea.origin.y + cropArea.size.height));
    CGContextSetRGBFillColor(context, kRGB_Value, kRGB_Value, kRGB_Value, 1);//颜色（RGB）,透明度
    CGContextFillRect(context, rectArea_D);
}



        /*AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA*/         // 区域A
        /*AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA*/         // 区域B
        /*AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA*/         // 区域C
        /*AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA*/         // 区域D
        /*AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA*/
        /*AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA*/
        /*AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA*/
        /*BBBBBBBBBB                CCCCCCCCCC*/
        /*BBBBBBBBBB                CCCCCCCCCC*/
        /*BBBBBBBBBB                CCCCCCCCCC*/
        /*BBBBBBBBBB    cropArea    CCCCCCCCCC*/
        /*BBBBBBBBBB                CCCCCCCCCC*/
        /*BBBBBBBBBB                CCCCCCCCCC*/
        /*BBBBBBBBBB                CCCCCCCCCC*/
        /*BBBBBBBBBB                CCCCCCCCCC*/
        /*DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD*/
        /*DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD*/
        /*DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD*/
        /*DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD*/
        /*DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD*/
        /*DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD*/
        /*DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD*/

@end
