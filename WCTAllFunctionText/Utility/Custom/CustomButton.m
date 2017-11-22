//
//  CustomButton.m
//  BnPlus
//
//  Created by sgs on 15/8/15.
//  Copyright (c) 2015年 Sgs. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

- (id) initWithFrame:(CGRect)frame Image:(UIImage *)image Title:(NSString *)title {
    self = [super initWithFrame:frame];
    if (self) {
        _imgViewIcon = [[UIImageView alloc] initWithFrame:CGRectMake(40, 15, (frame.size.width - 80), (frame.size.width - 80))];
        _imgViewIcon.backgroundColor = [UIColor clearColor];
        _imgViewIcon.image = image;
        [self addSubview:_imgViewIcon];
        
        // title
        _lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, _imgViewIcon.frame.size.height + _imgViewIcon.frame.origin.y + 15, frame.size.width, 20)];
        _lblTitle.backgroundColor = [UIColor clearColor];
        _lblTitle.textAlignment = NSTextAlignmentCenter;
        _lblTitle.textColor = [UIColor whiteColor];
        _lblTitle.font = [UIFont systemFontOfSize:17.0];
        _lblTitle.text = title;
        [self addSubview:_lblTitle];
    }
    return self;
}

// 图片和文字是横向排列
- (id) initWithFrame_H:(CGRect)frame Image:(UIImage *)image Title:(NSString *)title {
    self = [super initWithFrame:frame];
    if (self) {
        _imgViewIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, (frame.size.height - 51) / 2.0, 49, 51)];
        _imgViewIcon.backgroundColor = [UIColor clearColor];
        _imgViewIcon.image = image;
        [self addSubview:_imgViewIcon];
        
        // title
        _lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(_imgViewIcon.frame.size.width + _imgViewIcon.frame.origin.x + 10, (frame.size.height - 20) / 2.0, frame.size.width - (_imgViewIcon.frame.size.width + _imgViewIcon.frame.origin.x + 15) - 10, 20)];
        _lblTitle.backgroundColor = [UIColor clearColor];
        _lblTitle.textAlignment = NSTextAlignmentCenter;
        _lblTitle.textColor = [UIColor whiteColor];
        _lblTitle.font = [UIFont systemFontOfSize:17.0];
        _lblTitle.text = title;
        [self addSubview:_lblTitle];
    }
    return self;
}

@end
