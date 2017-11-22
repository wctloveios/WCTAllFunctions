//
//  BooldDetailShowFormView.h
//  WCTAllFunctionText
//
//  Created by four on 16/3/18.
//  Copyright © 2016年 王春涛. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 *   必须重写drawrect方法
 *
 *  @param rect
 */
@interface BooldDetailShowFormView : UIView
/**
 *  根据数据来画折线图（还能点击显示不同的内容）
 *
 *  @param frame    frame
 *  @param title    传入的表格名字
 *  @param array    折线上和显示的数据
 *  @param yArray   y轴上的标注
 *  @param xArray   x轴上的标注
 *  @param maxY     传入得最大y值
 *  @param average  y上间隔
 *  @param pointNum 折线显示点的个数（可以控制显示数据里面多少个数据）
 *
 *  @return 制作好的表格
 */
-(instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title andData:(NSArray *)array  andYLable:(NSArray *)yArray andXLabel:(NSArray *)xArray andMaxY:(NSInteger)maxY andAverage:(NSInteger)average andPointNum:(NSInteger)pointNum;

@end
