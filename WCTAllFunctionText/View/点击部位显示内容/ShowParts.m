//
//  ShowParts.m
//  WCTAllFunctionText
//
//  Created by four on 16/3/18.
//  Copyright © 2016年 王春涛. All rights reserved.
//

#import "ShowParts.h"

@implementation ShowParts
+ (NSString *)getPositionType:(CGPoint)point andLine:(NSInteger)line andColumn:(NSInteger)column{
    int x = point.x/(MainScreenWidth/column); // 横坐标
    int y = point.y/((MainScreenHeight-20)/line);  // 纵坐标
    //    NSString *str = [NSString stringWithFormat:@"这是%d-%d快方块被点击了",y,x];
    
    if(((4<= x)&&(x <=5)) && ((0<=y)&&(y<=3+1)))
    {
        NSString *str = @"头部被点击了";
        return str;
    }
    if(((4<= x)&&(x <=5)) && ((4+1<=y)&&(y<=4+1)))
    {
        NSString *str = @"脖子被点击了";
        return str;
    }
    if (((3<= x)&&(x <=6)) && ((5+1<=y)&&(y<=9+1))) {
        NSString *str = @"胸部被点击了";
        return str;
    }
    if (((3<= x)&&(x <=6)) && ((10+1<=y)&&(y<=13+1))) {
        NSString *str = @"腹部被点击了";
        return str;
    }
    if (((3<= x)&&(x <=6)) && ((13+1<=y)&&(y<=15+1))) {
        NSString *str = @"档部被点击了";
        return str;
    }
    if (((3<= x)&&(x <=6)) && ((15+1<=y)&&(y<=21+1))) {
        NSString *str = @"大腿被点击了";
        return str;
    }
    if (((3<= x)&&(x <=6)) && ((21+1<=y)&&(y<=27+1))) {
        NSString *str = @"小腿被点击了";
        return str;
    }
    if (((2<= x)&&(x <=2)) && ((5+1<=y)&&(y<=14+1))) {
        NSString *str = @"左手臂被点击了";
        return str;
    }
    if (((7<= x)&&(x <=7)) && ((5+1<=y)&&(y<=14+1))) {
        NSString *str = @"右手臂被点击了";
        return str;
    }
    if (((1<= x)&&(x <=2)) && ((14+1<=y)&&(y<=16+1))) {
        NSString *str = @"左手掌被点击了";
        return str;
    }
    if (((7<= x)&&(x <=8)) && ((14+1<=y)&&(y<=16+1))) {
        NSString *str = @"右手掌被点击了";
        return str;
    }
    if (((4<= x)&&(x <=4)) && ((28+1<=y)&&(y<=29+1))) {
        NSString *str = @"左脚被点击了";
        return str;
    }
    if (((5<= x)&&(x <=5)) && ((28+1<=y)&&(y<=29+1))) {
        NSString *str = @"右脚被点击了";
        return str;
    }
    
    return [NSString stringWithFormat:@"没点到身体部位"];
}

@end
