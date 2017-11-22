//
//  IconNameView.m
//  HealthBAT
//
//  Created by 梁寒冰 on 16/3/8.
//  Copyright © 2016年 KMHealthCloud. All rights reserved.
//

#import "IconNameView.h"

@implementation IconNameView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        
        self.iconImg = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width/2 - 29, 15, 58, 58)];
        [self addSubview:self.iconImg];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.iconImg.frame) - 5, CGRectGetMaxY(self.iconImg.frame) + 2, 68, 30)];
        self.nameLabel.backgroundColor = [UIColor clearColor];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        self.nameLabel.textColor = [WCTTool colorWithHexString:@"#676767"];
        self.nameLabel.font = [UIFont systemFontOfSize:13.0f];
        [self addSubview:self.nameLabel];
        
    }
    return self;
}


@end
