//
//  CustomTextField.m
//  CancerDoctor
//
//  Created by Wilson on 15/11/17.
//  Copyright © 2015年 KM. All rights reserved.
//

#import "CustomTextField.h"

@implementation CustomTextField

- (id) initWithFrame:(CGRect)frame Delegate:(id)delegate BackgroundColor:(UIColor *)bgColor ReturnKeyType:(UIReturnKeyType)returnKeyType KeyBoardType:(UIKeyboardType)keyBoardType Font:(UIFont *)font TextColor:(UIColor *)textColor Text:(NSString *)text Placeholder:(NSString *)placeholder ClearButtonModel:(UITextFieldViewMode)clearButtonModel IsSecurity:(BOOL)isSecurity {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = bgColor;
        self.delegate = delegate;
        self.returnKeyType = returnKeyType;
        self.keyboardType = keyBoardType;
        self.font = font;
        self.placeholder = placeholder;
        UILabel *lblLefTips = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
        lblLefTips.backgroundColor = [UIColor clearColor];
        self.leftViewMode = UITextFieldViewModeAlways;
        self.leftView = lblLefTips;
        self.clearButtonMode = clearButtonModel;
        self.textColor = textColor;
        self.secureTextEntry = isSecurity;
        self.text = text;
    }
    return self;
}

@end
