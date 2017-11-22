//
//  CustomLabel.m
//  CancerDoctor
//
//  Created by Wilson on 15/11/17.
//  Copyright © 2015年 KM. All rights reserved.
//

#import "CustomLabel.h"

@implementation CustomLabel

- (id) initWithFrame:(CGRect)frame BackgroundColor:(UIColor *)bgColor Font:(UIFont *)font TextColor:(UIColor *)txtColor Alignment:(NSTextAlignment)alignment Text:(NSString *)text {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = bgColor;
        self.font = font;
        self.textColor = txtColor;
        self.textAlignment = alignment;
        self.userInteractionEnabled = YES;
        self.text = text;
    }
    return self;
}

- (id) initWithFrame:(CGRect)frame BackgroundColor:(UIColor *)bgColor Font:(UIFont *)font TextColor:(UIColor *)txtColor Alignment:(NSTextAlignment)alignment Text:(NSString *)text MutilLine:(BOOL)isMutilLine {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = bgColor;
        self.font = font;
        self.textColor = txtColor;
        self.textAlignment = alignment;
        self.userInteractionEnabled = YES;
        self.text = text;
        if (isMutilLine) {
            self.lineBreakMode = NSLineBreakByCharWrapping;
            self.numberOfLines = 0;
        }
    }
    return self;
}

@end
