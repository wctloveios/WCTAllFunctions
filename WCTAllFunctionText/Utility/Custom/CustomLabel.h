//
//  CustomLabel.h
//  CancerDoctor
//
//  Created by Wilson on 15/11/17.
//  Copyright © 2015年 KM. All rights reserved.
//
//  功能：自定义Label
//

#import <UIKit/UIKit.h>

@interface CustomLabel : UILabel

- (id) initWithFrame:(CGRect)frame BackgroundColor:(UIColor *)bgColor Font:(UIFont *)font TextColor:(UIColor *)txtColor Alignment:(NSTextAlignment)alignment Text:(NSString *)text;

- (id) initWithFrame:(CGRect)frame BackgroundColor:(UIColor *)bgColor Font:(UIFont *)font TextColor:(UIColor *)txtColor Alignment:(NSTextAlignment)alignment Text:(NSString *)text MutilLine:(BOOL)isMutilLine;

@end
