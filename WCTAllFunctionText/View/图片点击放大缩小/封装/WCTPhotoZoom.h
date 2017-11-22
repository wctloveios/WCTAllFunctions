//
//  WCTPhotoZoom.h
//  图片点击变大缩小
//
//  Created by four on 16/3/3.
//  Copyright © 2016年 four. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WCTPhotoZoom : NSObject<UIScrollViewDelegate>
/**
 *	@brief	浏览头像
 *
 *	@param 	oldImageView 	头像所在的imageView
 */
+(void)showImage:(UIImageView*)avatarImageView;

@end
