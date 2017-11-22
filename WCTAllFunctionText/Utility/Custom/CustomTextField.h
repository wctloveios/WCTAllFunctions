//
//  CustomTextField.h
//  CancerDoctor
//
//  Created by Wilson on 15/11/17.
//  Copyright © 2015年 KM. All rights reserved.
//
//  功能：自定义TextField
//

#import <UIKit/UIKit.h>

@interface CustomTextField : UITextField

- (id) initWithFrame:(CGRect)frame Delegate:(id)delegate BackgroundColor:(UIColor *)bgColor ReturnKeyType:(UIReturnKeyType)returnKeyType KeyBoardType:(UIKeyboardType)keyBoardType Font:(UIFont *)font TextColor:(UIColor *)textColor Text:(NSString *)text Placeholder:(NSString *)placeholder ClearButtonModel:(UITextFieldViewMode)clearButtonModel IsSecurity:(BOOL)isSecurity;

@end
