//
//  UserDefault.h
//  WilsonProject
//
//  Created by Wilson on 16/1/11.
//  Copyright © 2016年 Wilson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UserDefaults : NSObject {
    NSUserDefaults *userDefaults;
}

+ (UserDefaults *) shareUserDefaults;

// 永久化设置值
- (void) setUserDefaultValues:(NSString* )value forKey:(NSString *)key;

// 永久化获取值
- (NSString *) getUserDefaultValuesWithKey:(NSString *)key;

// 获取字体（永久化数据）Scale
- (CGFloat) getFontScale;

@end
