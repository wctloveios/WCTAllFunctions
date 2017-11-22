//
//  UserDefault.m
//  WilsonProject
//
//  Created by Wilson on 16/1/11.
//  Copyright © 2016年 Wilson. All rights reserved.
//

#import "UserDefaults.h"

@implementation UserDefaults

static UserDefaults *userDefaults = nil;

+ (UserDefaults *) shareUserDefaults {
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        userDefaults = [[self alloc] init];
    });
    return userDefaults;
}

- (id) init {
    if (self = [super init]) {
        userDefaults = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

// 永久化赋值
- (void) setUserDefaultValues:(NSString* )value forKey:(NSString *)key {
    [userDefaults setObject:value forKey:key];
    [userDefaults synchronize];
}

// 永久化取值
- (NSString *) getUserDefaultValuesWithKey:(NSString *)key {
    NSString * value = @"";
    if ([userDefaults.dictionaryRepresentation.allKeys containsObject: key]) {
        value = [userDefaults objectForKey: key];
    }
    return value;
}

// 获取字体（永久化数据）Scale
- (CGFloat) getFontScale {
    CGFloat fontScale = [[self getUserDefaultValuesWithKey:@"FontScale"] floatValue];
    return fontScale;
}


@end
