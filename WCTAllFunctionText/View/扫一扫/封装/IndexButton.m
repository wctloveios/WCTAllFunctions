//
//  IndexButton.m
//  车主app
//
//  Created by 郭鹏飞 on 15/7/11.
//  Copyright (c) 2015年 沃特智联. All rights reserved.
//

#import "IndexButton.h"

@implementation IndexButton
@synthesize unReadLabel;
@synthesize countBg;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        countBg = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width - 50, 20, 18, 18)];
        countBg.image = [UIImage imageNamed:@"bg_seek_unRead"];
        [self addSubview:countBg];
        
        unReadLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 18, 18)];
        unReadLabel.font = [UIFont systemFontOfSize:10];
        unReadLabel.backgroundColor = [UIColor clearColor];
        unReadLabel.textColor = [UIColor whiteColor];
        unReadLabel.textAlignment = NSTextAlignmentCenter;
        unReadLabel.text = @"";
        [countBg addSubview:unReadLabel];
    }
    return self;
}

@end
