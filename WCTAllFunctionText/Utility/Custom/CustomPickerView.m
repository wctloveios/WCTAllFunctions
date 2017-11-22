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

#import "CustomPickerView.h"
#import <QuartzCore/QuartzCore.h>

#define kSemiModalAnimationDuration 0.3f

@interface CustomPickerView ()

- (void)_presentModelView;
- (void)_dismissModalView;

@end


@implementation CustomPickerView

@synthesize delegate = _delegate;
@synthesize ProvinceArray = _ProvinceArray;
@synthesize CitiesArray = _CitiesArray;
@synthesize AllCitiesArray = _AllCitiesArray;
@synthesize AreasArray = _AreasArray;
@synthesize PickerType = _PickerType;
@synthesize AllAreasArray = _AllAreasArray;
@synthesize DataSourcesArray = _DataSourcesArray;

- (id)init
{
    self = [super init];
    if (self) {
        
        CGSize size = [[UIScreen mainScreen] applicationFrame].size;
        self.frame = CGRectMake(0, 0, size.width, size.height/2.);
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        _originalSize = CGSizeMake(frame.size.width, frame.size.height);
    }
    return self;
}

- (id) initWithFrame:(CGRect)frame DataSources:(NSMutableArray *)arySources Type:(PickerType)type Title:(NSString *)title SelectIndex:(NSInteger)selectIndex {
    if(self = [super initWithFrame:frame]){
        _originalSize = CGSizeMake(frame.size.width, frame.size.height);
        
        _PickerType = type;
        _DataSourcesArray = arySources;
        nCurrentSelectedIndex = selectIndex;
        
        [self _initCommonUI:title];
    }
    return self;
}

- (id) initWithFrame:(CGRect)frame ProvinceArry:(NSMutableArray *)aryProvince CitiesArray:(NSMutableArray *)aryCities Type:(PickerType)type Title:(NSString *)title {
    if(self = [super initWithFrame:frame]){
        _originalSize = CGSizeMake(frame.size.width, frame.size.height);
        
        _PickerType = type;
        _AllCitiesArray = aryCities;
        _ProvinceArray = aryProvince;
        
        if ([aryCities count] > 0) {
            _CitiesArray = [aryCities objectAtIndex:0];
        }
        
        [self _initCommonUI:title];
    }
    return self;
}

- (id) initWithFrame:(CGRect)frame ProvinceArry:(NSMutableArray *)aryProvince CitiesArray:(NSMutableArray *)aryCities Areas:(NSMutableArray *)aryAreas Type:(PickerType)type Title:(NSString *)title {
    if(self = [super initWithFrame:frame]){
        _originalSize = CGSizeMake(frame.size.width, frame.size.height);
        
        _PickerType = type;
        _AllCitiesArray = aryCities;
        _ProvinceArray = aryProvince;
        
        _AllAreasArray = aryAreas;
        
        if ([aryCities count] > 0) {
            _CitiesArray = [aryCities objectAtIndex:0];
        }
        
        if ([aryAreas count] > 0) {
            _AreasArray = [[aryAreas objectAtIndex:0] objectAtIndex:0];
        }
        
        [self _initCommonUI:title];
    }
    return self;
}

- (id) initWithFrame:(CGRect)frame firstCompnent:(NSMutableArray *)firstCompnent secondCompnent:(NSMutableArray *)secondCompnent thirdCompnent:(NSMutableArray *)thirdCompnent Type:(PickerType)type Title:(NSString *)title {
    if(self = [super initWithFrame:frame]){
        _originalSize = CGSizeMake(frame.size.width, frame.size.height);
        _PickerType = type;
        
        _aryFirstCompnent = firstCompnent;
        _arySecondCompnent = secondCompnent;
        _aryThirdCompnent = thirdCompnent;
        
        [self _initCommonUI:title];
    }
    return self;
}

- (void)_initCommonUI:(NSString *)title
{
    _halfOriginalSize = CGSizeMake(_originalSize.width, _originalSize.height/2.0f);
    
    self.backgroundColor = [UIColor clearColor];
    
    UIView *helpView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, 250)];
    helpView.backgroundColor = [UIColor whiteColor];
    helpView.layer.cornerRadius = 5;
    
    pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, 240)];
    pickView.backgroundColor = [UIColor whiteColor];
    pickView.delegate = self;
    
    [helpView addSubview:pickView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame: CGRectMake((MainScreenWidth-(MainScreenWidth/3))/2, 5, MainScreenWidth/3, 35)];
    titleLabel.font = [UIFont systemFontOfSize:20 ];
    titleLabel.backgroundColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = title;
    [helpView addSubview: titleLabel];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.tag = 2000;
    leftBtn.frame = CGRectMake(5, 5, 70, 35);
    leftBtn.backgroundColor = [UIColor whiteColor];
    [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    [leftBtn setTitleColor:RGB(26, 162, 215) forState: UIControlStateNormal];
    [leftBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:20 ]];
    [leftBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.layer.cornerRadius = 5;
    [helpView addSubview:leftBtn];
    
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.tag = 2001;
    rightBtn.frame = CGRectMake(MainScreenWidth -70 , 5, 70, 35);
    rightBtn.backgroundColor = [UIColor whiteColor];
    [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    [rightBtn setTitleColor:RGB(26, 162, 215) forState: UIControlStateNormal];
    [rightBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:20 ]];
    [rightBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.layer.cornerRadius = 5;
    [helpView addSubview:rightBtn];
    [self addSubview:helpView];
}

- (void)show
{
    if (isPresent) {
        return;
    }
    [self _presentModelView];
}

- (void)dismiss
{
    [self _dismissModalView];
}


- (void)_presentModelView
{
    if (isPresent) {
        return;
    }
    UIWindow *keywindow = [[UIApplication sharedApplication] keyWindow];
    if (![keywindow.subviews containsObject:self] ) {
        
        CGRect sf = self.frame;
        CGRect vf = keywindow.frame;
        CGRect f  = CGRectMake(0, vf.size.height-sf.size.height, vf.size.width, sf.size.height);
        CGRect of = CGRectMake(0, 0, vf.size.width, vf.size.height-sf.size.height);
        NSStringFromCGRect(f);
        NSStringFromCGRect(of);
        UIView * overlay = [[UIView alloc] initWithFrame:keywindow.bounds];
        UIView* ss = [[UIView alloc] initWithFrame:keywindow.bounds];
        [overlay addSubview:ss];
        [keywindow addSubview:overlay];
        UIControl * dismissButton = [[UIControl alloc] initWithFrame:CGRectZero];
        [dismissButton addTarget:self action:@selector(_dismissModalView) forControlEvents:UIControlEventTouchUpInside];
        dismissButton.backgroundColor = [UIColor clearColor];
        dismissButton.frame = of;
        [overlay addSubview:dismissButton];
        
        self.frame = CGRectMake(0, vf.size.height, vf.size.width, sf.size.height);
        [keywindow addSubview:self];
        
        [UIView animateKeyframesWithDuration:kSemiModalAnimationDuration delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
            overlay.backgroundColor = [UIColor clearColor];
            overlay.backgroundColor = [UIColor blackColor];
            overlay.alpha = 0.4;
            self.frame = f;
        } completion:^(BOOL finished){
            isPresent = NO;
            
        }];
    }
    
}

- (void)_dismissModalView
{
    UIWindow * keywindow = [[UIApplication sharedApplication] keyWindow];
    UIView * modal = [keywindow.subviews objectAtIndex:keywindow.subviews.count-1];
    UIView * overlay = [keywindow.subviews objectAtIndex:keywindow.subviews.count-2];
    [UIView animateWithDuration:kSemiModalAnimationDuration animations:^{
        modal.frame = CGRectMake(0, keywindow.frame.size.height, modal.frame.size.width, modal.frame.size.height);
        overlay.backgroundColor = [UIColor blackColor];
        overlay.backgroundColor = [UIColor clearColor];
        overlay.alpha = 1;
    } completion:^(BOOL finished) {
        [overlay removeFromSuperview];
        [modal removeFromSuperview];
        //isPresent = NO;
    }];
    
}

-(void)clickAction:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if (_delegate && [_delegate conformsToProtocol:@protocol(CustomPickerViewDelegate)])
    {
        if (button.tag == 2001) {
            if (_PickerType == PickerType_OneGrade) {
                if (dataPickerIndex < [_DataSourcesArray count]) {
                    if ([_delegate respondsToSelector:@selector(CustomPickerView:didSelectTitle:Index:)]) {
                        [_delegate CustomPickerView:self didSelectTitle:_DataSourcesArray[dataPickerIndex] Index:nCurrentSelectedIndex];
                    }
                }
            }
            else if (_PickerType == PickerType_TwoGrade) {
                if (provicePickerIndex < [_ProvinceArray count]) {
                    NSDictionary *dictPro = [_ProvinceArray objectAtIndex:provicePickerIndex];
                    if (citiesPcickerIndex < [_CitiesArray count]) {
                        NSDictionary *dictCity = [_CitiesArray objectAtIndex:citiesPcickerIndex];
                        
                        if ([_delegate respondsToSelector:@selector(CustomPickerView:didSelectProvince:City:)]) {
                            [self.delegate CustomPickerView:self didSelectProvince:dictPro City:dictCity];
                        }
                    }
                }
            }
            else if (_PickerType == PickerType_ThrGrade) {
                if (provicePickerIndex < [_ProvinceArray count]) {
                    NSDictionary *dictPro = [_ProvinceArray objectAtIndex:provicePickerIndex];
                    if (citiesPcickerIndex < [_CitiesArray count]) {
                        NSDictionary *dictCity = [_CitiesArray objectAtIndex:citiesPcickerIndex];
                        
                        if (provicePickerIndex < [_AllAreasArray count]) {
                            NSMutableArray *ary = [_AllAreasArray objectAtIndex:provicePickerIndex];
                            if (citiesPcickerIndex < [ary count]) {
                                _AreasArray = [ary objectAtIndex:citiesPcickerIndex];
                                if (areaPickerIndex < [_AreasArray count]) {
                                    NSDictionary *dictArea = [_AreasArray objectAtIndex:areaPickerIndex];
                                    if ([self.delegate respondsToSelector:@selector(CustomPickerView:didSelectProvince:City:Area:)]) {
                                        [self.delegate CustomPickerView:self didSelectProvince:dictPro City:dictCity Area:dictArea];
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    if (_PickerType == PickerType_Four) {
        if (self.didSelecCompnents) {
            NSString *compnentString = @"";
            if (firstCompnentIndex < [_aryFirstCompnent count]) {
                compnentString = [compnentString stringByAppendingString:_aryFirstCompnent[firstCompnentIndex]];
            }
            if (secondCompnentIndex < [_arySecondCompnent count]) {
                compnentString = [compnentString stringByAppendingString:_arySecondCompnent[secondCompnentIndex]];
            }
            
            self.didSelecCompnents(compnentString);
        }
    }
    
    [self dismiss];
}

- (void)dealloc
{
    _delegate = nil;
}

#pragma mark - UIPickerViewDataSource

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (_PickerType == PickerType_OneGrade) {
        return 1;
    }
    else if (_PickerType == PickerType_TwoGrade) {
        return 2;
    }
    else if (_PickerType == PickerType_ThrGrade) {
        return 3;
    }
    else if (_PickerType == PickerType_Four) {
        return 3;
    }
    return 1;
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (_PickerType == PickerType_OneGrade) {
        if (component == 0) {
            return [_DataSourcesArray count];
        }
        return 0;
    }
    else if (_PickerType == PickerType_TwoGrade) {
        if (component == 0) {
            return [_ProvinceArray count];
        }
        return [_CitiesArray count];
    }
    else if (_PickerType == PickerType_ThrGrade) {
        if (component == 0) {
            return [_ProvinceArray count];
        }
        else if (component == 1) {
            
            return [_CitiesArray count];
        }
        return [_AreasArray count];
    }
    else if (_PickerType == PickerType_Four) {
        if (component == 0) {
            return [_aryFirstCompnent count];
        }
        else if (component == 1) {
            return [_arySecondCompnent count];
        }
        return [_aryThirdCompnent count];
    }
    return 0;
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (_PickerType == PickerType_OneGrade) {
        if (component == 0) {
            if (row < [_DataSourcesArray count]) {
                return _DataSourcesArray[row];
            }
            return @"";
        }
        return @"";
    }
    else if (_PickerType == PickerType_TwoGrade) {
        if (component == 0) {
            if (row < [_ProvinceArray count]) {
                NSDictionary *dict = _ProvinceArray[row];
                return [dict objectForKey:@"Name"];
            }
        }
        else {
            if (row < [_CitiesArray count]) {
                NSDictionary *dict = _CitiesArray[row];
                return [dict objectForKey:@"Name"];
            }
        }
    }
    else if (_PickerType == PickerType_ThrGrade) {
        if (component == 0) {
            if (row < [_ProvinceArray count]) {
                NSDictionary *dict = _ProvinceArray[row];
                return [dict objectForKey:@"Name"];
            }
        }
        else if (component == 1) {
            if (row < [_CitiesArray count]) {
                NSDictionary *dict = _CitiesArray[row];
                return [dict objectForKey:@"Name"];
            }
        }
        else {
            if (row < [_AreasArray count]) {
                NSDictionary *dict = [_AreasArray objectAtIndex:row];
                return [dict objectForKey:@"Name"];
            }
        }
    }
    else if (_PickerType == PickerType_Four) {
        if (component == 0) {
            if (row < [_aryFirstCompnent count]) {
                return _aryFirstCompnent[row];
            }
        }
        else if (component == 1) {
            if (row < [_arySecondCompnent count]) {
                return _arySecondCompnent[row];
            }
        }
        else {
            if (row < [_aryThirdCompnent count]) {
                return _aryThirdCompnent[row];
            }
        }
    }
    
    return @"";
}


- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (_PickerType == PickerType_OneGrade) {
        if (component == 0) {
            dataPickerIndex = row;
        }
        
        [pickView reloadAllComponents];
    }
    else if (_PickerType == PickerType_TwoGrade) {
        if (component == 0) {
            if (row < [_AllCitiesArray count]) {
                _CitiesArray = [_AllCitiesArray objectAtIndex:row];
            }
            provicePickerIndex = row;
        }
        else {
            citiesPcickerIndex = row;
        }
        
        [pickView reloadAllComponents];
    }
    else if (_PickerType == PickerType_ThrGrade) {
        if (component == 0) {
            if (row < [_AllCitiesArray count]) {
                _CitiesArray = [_AllCitiesArray objectAtIndex:row];
            }
            provicePickerIndex = row;
            if (provicePickerIndex < [_AllAreasArray count]) {
                NSMutableArray *ary = [_AllAreasArray objectAtIndex:provicePickerIndex];
                if (citiesPcickerIndex < [ary count]) {
                    _AreasArray = [ary objectAtIndex:citiesPcickerIndex];
                }
            }
        }
        else if (component == 1) {
            citiesPcickerIndex = row;
            if (provicePickerIndex < [_AllAreasArray count]) {
                NSMutableArray *ary = [_AllAreasArray objectAtIndex:provicePickerIndex];
                if (citiesPcickerIndex < [ary count]) {
                    _AreasArray = [ary objectAtIndex:citiesPcickerIndex];
                }
            }
        }
        else {
            areaPickerIndex = row;
        }
        
        [pickView reloadAllComponents];
    }
    else if (_PickerType == PickerType_Four) {
        if (component == 0) {
            firstCompnentIndex = row;
        }
        else if (component == 1) {
            secondCompnentIndex = row;
        }
        else {
            thirdCompnentIndex = row;
        }
        
        [pickView reloadAllComponents];
    }
}

@end

