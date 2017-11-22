//
//  CustomButton.h
//  BnPlus
//
//  Created by sgs on 15/8/15.
//  Copyright (c) 2015年 Sgs. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  创建图片文字不重合的button（图在上、图在左）
 *  *****注意：尺寸自己可以改动
 */
@interface CustomButton : UIButton

@property (nonatomic, retain) UIImageView *imgViewIcon;
@property (nonatomic, retain) UILabel *lblTitle;

- (id) initWithFrame:(CGRect)frame Image:(UIImage *)image Title:(NSString *)title;

- (id) initWithFrame_H:(CGRect)frame Image:(UIImage *)image Title:(NSString *)title;

@end
