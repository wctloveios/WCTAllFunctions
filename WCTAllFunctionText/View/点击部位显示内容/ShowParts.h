//
//  ShowParts.h
//  WCTAllFunctionText
//
//  Created by four on 16/3/18.
//  Copyright © 2016年 王春涛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ShowParts : NSObject
/**
 *  返回位置信息(例如本图片返回点击的部位：具体自己去区分)
 *
 *  @param point  传入点击的点在俯视图的位置
 *  @param line   行
 *  @param column 列
 */
+ (NSString *)getPositionType:(CGPoint)point andLine:(NSInteger)line andColumn:(NSInteger)column;
@end
