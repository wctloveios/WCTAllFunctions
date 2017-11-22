//
//  FromVC.h
//  FormInterfaceArrangement
//
//  Created by four on 16/2/16.
//  Copyright © 2016年 four. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FromVC : UIView

//来标记数组下标
@property (nonatomic,assign) NSInteger index;

@property (nonatomic,strong) NSArray *array;

@property (nonatomic,assign) NSInteger line;

@property (nonatomic,assign) NSInteger arrange;

@property (nonatomic,assign) NSInteger heigth;

/**
 *  规则的表格
 *
 *  @param array   数据源
 *  @param line    行
 *  @param arrange 列
 *  @param heigh   每个单元格的高的
 */
-(void)showFormWithData:(NSArray *)array andLine:(NSInteger)line andArrange:(NSInteger)arrange andHeigh:(CGFloat)heigh;

/**
 *  不规则的表格1 (宽度不一)
 *
 *  @param array   数据源
 *  @param line    行
 *  @param arrange 列
 *  @param heigh   每个单元格的高的
 */
-(void)showFormWithData1:(NSArray *)array andLine:(NSInteger)line andArrange:(NSInteger)arrange andHeigh:(CGFloat)heigh;

/**
 *  不规则的表格2（中间有空白，宽度按比例）
 *
 *  @param array   数据源
 *  @param line    行
 *  @param arrange 列
 *  @param heigh   每个单元格的高的
 */
-(void)showFormWithData2:(NSArray *)array andLine:(NSInteger)line andArrange:(NSInteger)arrange andHeigh:(CGFloat)heigh;
@end
