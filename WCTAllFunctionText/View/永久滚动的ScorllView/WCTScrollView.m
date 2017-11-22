//
//  WCTScrollView.m
//  永久滚动的ScrollView封装
//
//  Created by four on 16/2/24.
//  Copyright © 2016年 four. All rights reserved.
//

#import "WCTScrollView.h"
#import <objc/runtime.h>

#define Main_Width self.frame.size.width
#define Main_Height self.frame.size.height

@implementation WCTScrollView
{
    NSArray *imageItems;
    UIScrollView *scrollV;
    UIPageControl *pageControl;
    NSTimer *scrollTimer;
    
    int lastX;
}
//自动滚动开关间隔时间
static CGFloat SWITCH_FOCUS_PICTURE_INTERVAL = 3.0;

-(instancetype)initWithFrame:(CGRect)frame imageItems:(NSArray *)array
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //获取图片数组
        imageItems = [self judgeImageArrayCount:array];
        
        //搭建scrollView和PageContrl
        [self initScrollViewAndPageControl];
        
        
        //开启计时滚动，移动scrollV就停止，重新计时
        [self statrTimer];
    }
    return self;
}

/**
 *  根据数组个数确定图片数量
 *
 *  @param array  一个新数组（图片数目会增加两张或者不变）
 */
-(NSArray*)judgeImageArrayCount:(NSArray *)array
{
    NSMutableArray *imageArray = [[NSMutableArray alloc]init];
    
    if(array.count > 1)
    {
        //至少两张
        @autoreleasepool {
            for (int i=0; i<array.count; i++) {
                [imageArray addObject:array[i]];
            }
            
            for (int i=0; i<array.count; i++) {
                //插到第一个
                if (i == array.count - 1 ) {
                    [imageArray insertObject:array[i] atIndex:0];
                }
                //放最后
                if (i == 0) {
                    [imageArray addObject:array[0]];
                }
            }
        }
    }
    else
    {
        //只有一张（最少一张）
        [imageArray addObject:array[0]];
    }
    
    return imageArray;
}

/**
 *  创建ScrollView
 */
-(void)initScrollViewAndPageControl
{
    scrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, Main_Width, Main_Height)];
    scrollV.contentSize = CGSizeMake(Main_Width * imageItems.count, Main_Height);
    scrollV.backgroundColor = [UIColor grayColor];
    scrollV.bounces = NO;
    scrollV.showsHorizontalScrollIndicator = NO;
    scrollV.showsVerticalScrollIndicator = NO;
    scrollV.contentOffset = CGPointMake(Main_Width, 0);
    scrollV.delegate = self;
    scrollV.pagingEnabled = YES;

    [self addSubview:scrollV];
    
    @autoreleasepool {
        for (int i=0; i<imageItems.count; i++) {
            UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(i * Main_Width, 0, Main_Width, Main_Height)];
//            NSString *path = [[NSBundle mainBundle] pathForResource: [NSString stringWithFormat:@"%@", imageItems[i]] ofType:@"png"];
//            UIImage *image = [[UIImage alloc]initWithContentsOfFile:path];
            UIImage *image = [UIImage imageNamed:imageItems[i]];
            imageV.image = image;
            [scrollV addSubview:imageV];
        }
    }
    
    pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, Main_Height - 30 , Main_Width, 30)];
    pageControl.numberOfPages = imageItems.count>1?imageItems.count -2:imageItems.count;
    pageControl.currentPage = 0;
    //关闭用户交互（不可点击）
    pageControl.userInteractionEnabled = NO;
    if ([[[UIDevice currentDevice] systemVersion] intValue] >= 6.0)
    {
        pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
        pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    }
    if (imageItems.count == 1) {
        pageControl.hidden = YES;
    }
    [self addSubview:pageControl];
    
}

#pragma mark - 加入计时器，加到runLoop中
/**
 *  计时器开始计时
 */
-(void) statrTimer
{
    if (scrollTimer == nil)
    {
        //切换图片
        scrollTimer = [NSTimer scheduledTimerWithTimeInterval:SWITCH_FOCUS_PICTURE_INTERVAL target:self selector:@selector(changeImageShowOnView) userInfo:nil repeats:NO];
        //加入runloop中
        [[NSRunLoop currentRunLoop] addTimer:scrollTimer forMode:NSRunLoopCommonModes];
    }
    
}
/**
 *  停止计时器
 */
-(void) stopTimer
{
    [scrollTimer invalidate];
    scrollTimer = nil;
}

/**
 *  获取当前位置和下标
 */
- (void)changeImageShowOnView
{
    CGFloat targetX = scrollV.contentOffset.x + scrollV.frame.size.width;
    targetX = (int)(targetX/Main_Width) * Main_Width;
    if (lastX != targetX)
    {
        lastX = targetX;
        //转成对象
        NSString *string = [NSString stringWithFormat:@"%f",targetX];
        //开辟线程去完成移动（传入下标）
        [self performSelectorOnMainThread:@selector(moveToTargetPosition:) withObject:string waitUntilDone:NO];
    }
    
}

/**
 *  移动到指定位置
 *
 *  @param string   获取下标
 */
- (void)moveToTargetPosition:(NSString *)string
{
    float targetX = [string floatValue];
    
    if (targetX >= Main_Width * ([imageItems count] -1))
    {
        [scrollV setContentOffset:CGPointMake(targetX, 0) animated:YES];
    }
    else
    {
        /**
         *  判断设备的版本
         */
        if ([[[UIDevice currentDevice] systemVersion] intValue] >= 7.0) {
            [UIView animateKeyframesWithDuration:0.5 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
                [scrollV setContentOffset:CGPointMake(targetX, 0)];
            } completion:^(BOOL finished){
            }];
        }
        else {
            [scrollV setContentOffset:CGPointMake(targetX, 0) animated:YES];
        }
    }
}

#pragma mark - UIScrollViewDelegate
//开始滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(changeImageShowOnView) object:nil];
    [self stopTimer];
    
    float targetX = scrollView.contentOffset.x;
    if ([imageItems count]>=3 )
    {
        if (targetX >= Main_Width * ([imageItems count] -1)) {
            targetX = Main_Width;
            [scrollV setContentOffset:CGPointMake(targetX, 0) animated:NO];
        }
        else if(targetX <= 0)
        {
            targetX = Main_Width *([imageItems count]-2);
            
            [scrollV setContentOffset:CGPointMake(targetX, 0) animated:NO];
        }
    }
    lastX = targetX;
    NSInteger page = (scrollV.contentOffset.x+Main_Width/2.0) / Main_Width;
    if ([imageItems count] > 1)
    {
        page --;
        if (page >= pageControl.numberOfPages)
        {
            page = 0;
        }else if(page <0)
        {
            page = pageControl.numberOfPages -1;
        }
    }
    pageControl.currentPage = page;
    if ([imageItems count]>1)
    {
        [self performSelector:@selector(statrTimer) withObject:nil];
    }
    
}
//滚动视图并结束拖动
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
    {
        CGFloat targetX = scrollV.contentOffset.x + scrollV.frame.size.width;
        targetX = (int)(targetX/Main_Width) * Main_Width;
        NSString *string = [NSString stringWithFormat:@"%f",targetX];
        [self moveToTargetPosition:string];
    }
}

@end
