//
//  BooldDetailShowFormView.m
//  WCTAllFunctionText
//
//  Created by four on 16/3/18.
//  Copyright © 2016年 王春涛. All rights reserved.
//

#import "BooldDetailShowFormView.h"

#import <QuartzCore/QuartzCore.h>

@implementation BooldDetailShowFormView
{
    /**
     *  这里定义的
     */
    CGMutablePathRef _path; //记录路径
    NSInteger  _allHeight;  //坐标总高度
    NSInteger  _allWidth;   //坐标总宽度
    CGFloat _littleHeight;  //坐标尺等分宽度
    UILabel *_mmHgLabel;    //mmhg指标
    UILabel *_timeLable;    //记录时间
    UILabel *_pulseLabel;   //脉搏次数
    /**
     *  需要传入的
     */
    NSInteger _pointNum;    //显示点个数
    NSArray *_dataArray;    //数据
    NSArray *_yLabelArray;  //纵坐标的数值（内容）
    NSArray *_xLabelArray;  //横坐标的数值（内容）
    NSInteger _maxY;        //等分（除数）
    NSInteger _average;      //等分 (以多少等分)
}

-(instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title  andData:(NSArray *)array andYLable:(NSArray *)yArray andXLabel:(NSArray *)xArray andMaxY:(NSInteger)maxY andAverage:(NSInteger)average andPointNum:(NSInteger)pointNum;
{
    if(self = [super initWithFrame:frame])
    {
        //初始化
        _pointNum = pointNum;
        _dataArray = [NSArray arrayWithArray:array];
        _yLabelArray = [NSArray arrayWithArray:yArray];
        _xLabelArray = [NSArray arrayWithArray:xArray];
        _average = average;
        _maxY = maxY;
        
        //创建一个路径，来存储坐标点
        self.backgroundColor = [UIColor whiteColor];
        _path = CGPathCreateMutable();
        
        //做全部适配
        _allHeight = (MainScreenHeight - 100 - 64 - 30 - 70);// 图表从导航栏下面30到底部上面100+70
        _allWidth= (MainScreenWidth - 50 - 20 - 10);//左边70开始到后面10
        
        //画两条虚线
        [self draw1];
        [self draw2];
        
        //纵坐标内容
        [self initLabel];
        
        if (_dataArray.count == 0) {
            
            //底部内容
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((MainScreenWidth-200)/2, (_allHeight-100)/2, 200, 100)];
            label.text = @"您目前没有记录";
            label.font = [UIFont systemFontOfSize:25];
            label.textAlignment = NSTextAlignmentCenter;
            [self addSubview:label];
        }
        else
        {
            //底部内容
            [self initDesc:title];
            
            //画点
            [self initDrawPointAndTitleWithDict:array];
        }
        
        
    }
    return self;
}

/**
 *  画实线
 */
- (void)drawRect:(CGRect)rect {
    
    CGContextRef con = UIGraphicsGetCurrentContext();
    
    //绘制一条灰色线
    [[UIColor lightGrayColor] setStroke];
    CGContextMoveToPoint(con, 50, 30);
    CGContextAddLineToPoint(con, 50, MainScreenHeight - 100 - 64 - 70);
    CGContextSetLineWidth(con, 1);
    CGContextStrokePath(con);
    
    //再绘制一个灰色的线
    [[UIColor lightGrayColor] setStroke];
    CGContextMoveToPoint(con, 50, MainScreenHeight - 100 - 64 - 70 );
    CGContextAddLineToPoint(con, MainScreenWidth-10, MainScreenHeight - 100 - 64 - 70);
    CGContextSetLineWidth(con, 1);
    CGContextStrokePath(con);
    
}
/**
 *  画虚线，上面那条
 */
-(void)draw1{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.bounds];
    [shapeLayer setPosition:self.center];
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    
    // 设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:[[UIColor redColor] CGColor]];
    
    // 3.0f设置虚线的宽度
    [shapeLayer setLineWidth:1.0f];
    [shapeLayer setLineJoin:kCALineJoinRound];
    
    // 3=线的宽度 1=每条线的间距
    [shapeLayer setLineDashPattern:
     [NSArray arrayWithObjects:[NSNumber numberWithInt:3],
      [NSNumber numberWithInt:1],nil]];
    
    // Setup the path
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 50, 30 + ((CGFloat)_allHeight/(_maxY/_average)) - 64);
    CGPathAddLineToPoint(path, NULL,  MainScreenWidth-10, 30 + ((CGFloat)_allHeight/(_maxY/_average)) - 64);
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    // 可以把self改成任何你想要的UIView, 下图演示就是放到UITableViewCell中的
    [[self layer] addSublayer:shapeLayer];
    
}
/**
 *  画虚线，下面这条
 */
-(void)draw2{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.bounds];
    [shapeLayer setPosition:self.center];
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    
    // 设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:[[UIColor redColor] CGColor]];
    
    // 3.0f设置虚线的宽度
    [shapeLayer setLineWidth:1.0f];
    [shapeLayer setLineJoin:kCALineJoinRound];
    
    // 3=线的宽度 1=每条线的间距
    [shapeLayer setLineDashPattern:
     [NSArray arrayWithObjects:[NSNumber numberWithInt:3],
      [NSNumber numberWithInt:1],nil]];
    
    // Setup the path
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 50, MainScreenHeight - 64 -100 - 70 - (CGFloat)_allHeight/(_maxY/_average) + 5 - 64);
    CGPathAddLineToPoint(path, NULL,  MainScreenWidth-10, MainScreenHeight- 64 - 100 - 70 - (CGFloat)_allHeight/(_maxY/_average) + 5 - 64);
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    
    
    // 可以把self改成任何你想要的UIView, 下图演示就是放到UITableViewCell中的
    [[self layer] addSublayer:shapeLayer];
}
/**
 *  写数字
 */
-(void)initLabel
{
    //将纵坐标分成135份(这里必须设置成CGFloat的格式，失之毫厘谬以千里)
    _littleHeight = (CGFloat)_allHeight/(CGFloat)_maxY;
    
    @autoreleasepool {
        //+1是为了都能遍历到
        for (int i=0; i<_maxY+1; i++) {
            if(i%_average == 0){
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, i*_littleHeight + 20, 50,  20)];//这里高度不是从30而是从20开始，为了好看
                label.text = _yLabelArray[i/_average];
                label.textAlignment = NSTextAlignmentCenter;
                label.textColor = kAllTextGrayColor;
                label.font = [UIFont systemFontOfSize:14];
                [self addSubview:label];
            }
        }
    }
}
/**
 *  底部描述
 */
-(void)initDesc:(NSString *)title
{
    //默认显示第一个点的数据
    NSDictionary *dict = _dataArray[0];
    
    if ([title isEqualToString:@"血压"]) {
        UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, MainScreenHeight - 70 - 64 , MainScreenWidth/2 + 60, 70)];
        leftView.backgroundColor = [WCTTool colorWithHexString:@"#fc9f26"];
        [self addSubview:leftView];
        
        _mmHgLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth/2 + 60, 35)];
        _mmHgLabel.text = [dict objectForKey:@"mmHg"];
        _mmHgLabel.textAlignment = NSTextAlignmentCenter;
        _mmHgLabel.textColor = [UIColor whiteColor];
        _mmHgLabel.font = [UIFont systemFontOfSize:20];
        [leftView addSubview:_mmHgLabel];
        
        _timeLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 35, MainScreenWidth/2 + 60, 35)];
        _timeLable.text = [dict objectForKey:@"time"];
        _timeLable.textAlignment = NSTextAlignmentCenter;
        _timeLable.textColor = [UIColor whiteColor];
        _timeLable.font = [UIFont systemFontOfSize:20];
        [leftView addSubview:_timeLable];
        
        
        UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(MainScreenWidth/2 + 60, MainScreenHeight - 70 - 64, MainScreenWidth/2 - 60, 70)];
        rightView.backgroundColor = [WCTTool colorWithHexString:@"#47d9bf"];
        [self addSubview:rightView];
        
        _pulseLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth/2 - 60, 70)];
        _pulseLabel.text = [NSString stringWithFormat:@"+%@脉搏",[dict objectForKey:@"point"]];
        _pulseLabel.font = [UIFont systemFontOfSize:20];
        _pulseLabel.textAlignment = NSTextAlignmentCenter;
        _pulseLabel.textColor = [UIColor whiteColor];
        [rightView addSubview:_pulseLabel];
        
    }
    else if ([title isEqualToString:@"血糖"]) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, MainScreenHeight - 70 - 64 , MainScreenWidth, 70)];
        view.backgroundColor = [WCTTool colorWithHexString:@"#ec5e5e"];
        [self addSubview:view];
        
        _mmHgLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, 35)];
        _mmHgLabel.text = [dict objectForKey:@"mmHg"];
        _mmHgLabel.textAlignment = NSTextAlignmentCenter;
        _mmHgLabel.textColor = [UIColor whiteColor];
        _mmHgLabel.font = [UIFont systemFontOfSize:20];
        [view addSubview:_mmHgLabel];
        
        _timeLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 35, MainScreenWidth, 35)];
        _timeLable.text = [dict objectForKey:@"time"];
        _timeLable.textAlignment = NSTextAlignmentCenter;
        _timeLable.textColor = [UIColor whiteColor];
        _timeLable.font = [UIFont systemFontOfSize:20];
        [view addSubview:_timeLable];
    }
    else {
        // 血氧
        {
            UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, MainScreenHeight - 70 - 64 , MainScreenWidth/2 + 60, 70)];
            leftView.backgroundColor = [WCTTool colorWithHexString:@"#fc9f26"];
            [self addSubview:leftView];
            
            _mmHgLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth/2 + 60, 35)];
            _mmHgLabel.text = [dict objectForKey:@"mmHg"];
            _mmHgLabel.textAlignment = NSTextAlignmentCenter;
            _mmHgLabel.textColor = [UIColor whiteColor];
            _mmHgLabel.font = [UIFont systemFontOfSize:20];
            [leftView addSubview:_mmHgLabel];
            
            _timeLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 35, MainScreenWidth/2 + 60, 35)];
            _timeLable.text = [dict objectForKey:@"time"];
            _timeLable.textAlignment = NSTextAlignmentCenter;
            _timeLable.textColor = [UIColor whiteColor];
            _timeLable.font = [UIFont systemFontOfSize:20];
            [leftView addSubview:_timeLable];
            
            
            UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(MainScreenWidth/2 + 60, MainScreenHeight - 70 - 64, MainScreenWidth/2 - 60, 70)];
            rightView.backgroundColor = [WCTTool colorWithHexString:@"#47d9bf"];
            [self addSubview:rightView];
            
            _pulseLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth/2 - 60, 70)];
            _pulseLabel.text = [NSString stringWithFormat:@"+%@脉搏",[dict objectForKey:@"point"]];
            _pulseLabel.font = [UIFont systemFontOfSize:20];
            _pulseLabel.textAlignment = NSTextAlignmentCenter;
            _pulseLabel.textColor = [UIColor whiteColor];
            [rightView addSubview:_pulseLabel];
            
            //血氧需要在设置横向标尺
            //几个点就显示几个（还是显示最多的个数）？？？？这里直接设置7个点
            @autoreleasepool {
                for (int i=0; i<_pointNum; i++) {
                    NSDictionary *dict = _xLabelArray[i];
                    
                    UILabel *label = [[UILabel alloc]init];
                    
                    if(i%2 == 0)
                        label.frame = CGRectMake(i*((CGFloat)_allWidth/(CGFloat)_pointNum) + 50, MainScreenHeight - 70 - 64 - 70 - 20 , 40, 40);
                    else
                        label.frame = CGRectMake(i*((CGFloat)_allWidth/(CGFloat)_pointNum) + 50, MainScreenHeight - 70 - 64 - 35  - 20, 40, 40);
                    
                    //自己定义背景颜色进行排版
                    //                    label.backgroundColor = [UIColor redColor];
                    label.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"date"]];
                    label.numberOfLines = 2;
                    label.textColor = kAllTextGrayColor;
                    label.textAlignment = NSTextAlignmentLeft;
                    label.font = [UIFont systemFontOfSize:12];
                    [self addSubview:label];
                }
            }
        }
    }
}
/**
 *  描点画线
 *
 *  @param array 数据数组
 */
-(void)initDrawPointAndTitleWithDict:(NSArray *)array
{
    //通过设置点的个数来控制显示数据里多少数据
    for (int i=0; i<_pointNum; i++) {
        NSDictionary *dict1 = array[i];
        if(_pointNum == 1){
            //            NSDictionary *dict2 = array[i+1];
            CGFloat p1 = [[dict1 objectForKey:@"point"] floatValue];
            CGFloat p2 = [[dict1 objectForKey:@"point"] floatValue];
            
            NSString *title1 = [dict1 objectForKey:@"title"];
            NSString *title2 = [dict1 objectForKey:@"title"];
            
            // 还要处理Y和划线
            CGPoint point1 = CGPointMake(i*((CGFloat)_allWidth/(CGFloat)_pointNum)+70, p1);
            CGPoint point2 = CGPointMake(i*((CGFloat)_allWidth/(CGFloat)_pointNum)+70, p2);
            //只有一个点
            [self drawandPoint:point1 andPoint2:point2 andTitle1:title1 andTitle2:title2];
        }
        if (i+1<_pointNum) {
            NSDictionary *dict2 = array[i+1];
            CGFloat p1 = [[dict1 objectForKey:@"point"] floatValue];
            CGFloat p2 = [[dict2 objectForKey:@"point"] floatValue];
            
            NSString *title1 = [dict1 objectForKey:@"title"];
            NSString *title2 = [dict2 objectForKey:@"title"];
            
            // 还要处理Y和划线
            CGPoint point1 = CGPointMake(i*((CGFloat)_allWidth/(CGFloat)_pointNum)+70, p1);
            CGPoint point2 = CGPointMake((i+1)*((CGFloat)_allWidth/(CGFloat)_pointNum)+70, p2);
            
            [self drawandPoint:point1 andPoint2:point2 andTitle1:title1 andTitle2:title2];
        }
    }
}
/**
 *  传入数据画直线
 *
 *  @param point1 点1
 *  @param point2 点2
 *  @param title1 点1的标注
 *  @param title2 点2的标注
 */
- (void)drawandPoint:(CGPoint)point1 andPoint2:(CGPoint)point2 andTitle1:(NSString *)title1 andTitle2:(NSString *)title2{
    
    //     NSLog(@"point1==%f",point1.x);
    //     NSLog(@"point1==%f",point1.y);
    //     NSLog(@"point2==%f",point2.x);
    //     NSLog(@"point2==%f",point2.y);
    
    //横坐标15的高度
    CGFloat zore = _maxY*_littleHeight + 20;
    //    NSLog(@"zore == %f",zore);
    
    CGFloat changePointY1 = zore - point1.y*_littleHeight + 10;//加10是为了配合lable的位置
    CGFloat changePointY2 = zore - point2.y*_littleHeight + 10;
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.bounds];
    [shapeLayer setPosition:self.center];
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    // 设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:[[UIColor redColor] CGColor]];
    // 3.0f设置虚线的宽度
    [shapeLayer setLineWidth:1.0f];
    [shapeLayer setLineJoin:kCALineJoinRound];
    // 3=线的宽度 1=每条线的间距
    [shapeLayer setLineDashPattern:
     [NSArray arrayWithObjects:[NSNumber numberWithInt:3],
      [NSNumber numberWithInt:0.00001],nil]];
    // Setup the path
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, point1.x, changePointY1 - 64);
    CGPathAddLineToPoint(path, NULL,  point2.x, changePointY2 - 64);
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    // 可以把self改成任何你想要的UIView, 下图演示就是放到UITableViewCell中的
    [[self layer] addSublayer:shapeLayer];
    
    /**
     设置label显示内容，设置小点操作点击事件
     */
    UILabel *label1 = [[UILabel alloc]init];
    label1.frame = CGRectMake(point1.x-20, changePointY1 - 30, 40, 30);
    label1.text = title1;
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = kAllTextGrayColor;
    label1.font = [UIFont systemFontOfSize:10];
    [self addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(point2.x-20, changePointY2 - 30, 40, 30)];
    label2.text = title2;
    label2.textAlignment = NSTextAlignmentCenter;
    label2.textColor = kAllTextGrayColor;
    label2.font = [UIFont systemFontOfSize:10];
    [self addSubview:label2];
    
    /**
     *  按钮的大小根据自己需求更改
     */
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    button1.frame =CGRectMake(point1.x-10, changePointY1-10, 20, 20);
    button1.backgroundColor = [UIColor redColor];
    button1.layer.cornerRadius = 10;
    [button1 addTarget:self action:@selector(pressPoint:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTitle:title1 forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
    [self addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeSystem];
    button2.frame =CGRectMake(point2.x-10, changePointY2-10, 20, 20);
    button2.backgroundColor = [UIColor redColor];
    button2.layer.cornerRadius = 10;
    [button2 setTitle:title2 forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(pressPoint:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button2];
}
/**
 *  点击圆点事件（根据按钮父视图的位置）
 *
 *  @param button 传入的按钮
 */
-(void)pressPoint:(UIButton *)button
{
    NSLog(@"能点击了");
    
    // 通过获取button的俯视图（view）的x值（位置），来计算下标（是第几个点）
    CGFloat buttonX = button.frame.origin.x;
    NSLog(@"buttonX == %f",buttonX);
    // 位置除上每个点之间的宽度（取整）
    int index = (int)(buttonX - 50)/((CGFloat)_allWidth/(CGFloat)_pointNum);
    NSLog(@"index == %d",index);
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSDictionary *dict= _dataArray[index];
        NSLog(@"%@",dict);
        _pulseLabel.text = [NSString stringWithFormat:@"+%@脉搏",[dict objectForKey:@"point"]];
        _timeLable.text = [dict objectForKey:@"time"];
        _mmHgLabel.text = [dict objectForKey:@"mmHg"];
    });
}

@end
