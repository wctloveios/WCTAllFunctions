//
//  WCTScrollView.h
//  永久滚动的ScrollView封装
//
//  Created by four on 16/2/24.
//  Copyright © 2016年 four. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WCTScrollView : UIView<UIScrollViewDelegate>

/**
 *  通过图片数组和本对象frame确定框架
 *
 *  @param frame 本对象frame
 *  @param array 图片数组
 */
- (instancetype)initWithFrame:(CGRect)frame imageItems:(NSArray *)array;

@end
