/*
 The MIT License (MIT)
 
 Copyright (c) 2013 SuXinDe (Email: suxinde2009@126.com)
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

// UITabBar
// UIToolbar
// UINavigationBar

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    PickerType_OneGrade = 0,
    PickerType_TwoGrade,
    PickerType_ThrGrade,
    PickerType_Four,
}PickerType;

@class CustomPickerView;

@protocol CustomPickerViewDelegate <NSObject>
@optional

- (void)CustomPickerView:(CustomPickerView *)CustomPickerView didSelectTitle:(NSString *)title Index:(NSInteger)index;

- (void)CustomPickerView:(CustomPickerView *)CustomPickerView didSelectProvince:(NSDictionary *)provinceDict City:(NSDictionary *)cityDict;

- (void)CustomPickerView:(CustomPickerView *)CustomPickerView didSelectProvince:(NSDictionary *)provinceDict City:(NSDictionary *)cityDict Area:(NSDictionary *)areaDict;

@end

@interface CustomPickerView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>
{
@private
    __weak id<CustomPickerViewDelegate>  _delegate;
    CGSize                 _originalSize;
    CGSize                 _halfOriginalSize;
    NSInteger provicePickerIndex;
    NSInteger citiesPcickerIndex;
    NSInteger areaPickerIndex;
    NSInteger dataPickerIndex;
    NSInteger nCurrentSelectedIndex;
    BOOL                    isPresent;
    
    NSInteger firstCompnentIndex;
    NSInteger secondCompnentIndex;
    NSInteger thirdCompnentIndex;
    
    UIPickerView *pickView;
}

@property (nonatomic, weak) id<CustomPickerViewDelegate> delegate;     // weak reference. default is nil
@property (nonatomic, retain) NSMutableArray * ProvinceArray; // 省份数据源
@property (nonatomic, retain) NSMutableArray * CitiesArray;   // 城市数据源
@property (nonatomic, retain) NSMutableArray * AllCitiesArray;   // 城市数据源
@property (nonatomic, retain) NSMutableArray * AreasArray;       // 区镇县数据源
@property (nonatomic, retain) NSMutableArray * AllAreasArray;
@property (nonatomic, assign) PickerType PickerType;
@property (nonatomic, retain) NSMutableArray * DataSourcesArray;

// 三级数据
@property (nonatomic, retain) NSMutableArray *aryFirstCompnent;
@property (nonatomic, retain) NSMutableArray *arySecondCompnent;
@property (nonatomic, retain) NSMutableArray *aryThirdCompnent;

@property (nonatomic, copy) void (^didSelecCompnents)(NSString *values);

- (id) initWithFrame:(CGRect)frame DataSources:(NSMutableArray *)arySources Type:(PickerType)type Title:(NSString *)title SelectIndex:(NSInteger)selectIndex;

- (id) initWithFrame:(CGRect)frame ProvinceArry:(NSMutableArray *)aryProvince CitiesArray:(NSMutableArray *)aryCities Type:(PickerType)type Title:(NSString *)title;

- (id) initWithFrame:(CGRect)frame ProvinceArry:(NSMutableArray *)aryProvince CitiesArray:(NSMutableArray *)aryCities Areas:(NSMutableArray *)aryAreas Type:(PickerType)type Title:(NSString *)title;

- (id) initWithFrame:(CGRect)frame firstCompnent:(NSMutableArray *)firstCompnent secondCompnent:(NSMutableArray *)secondCompnent thirdCompnent:(NSMutableArray *)thirdCompnent Type:(PickerType)type Title:(NSString *)title;

- (void)show;
- (void)dismiss;

@end
