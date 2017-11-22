//
//  WeastMedicinesTableViewCell.h
//  PalmDoctor
//
//  Created by four on 16/2/5.
//  Copyright © 2016年 km. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeastMedicinesTableViewCell : UITableViewCell

//  药名
@property (nonatomic, strong) UILabel *nameLabel;
//  规格
@property (nonatomic, strong) UILabel *rankLabel;
//  厂家
@property (nonatomic, strong) UILabel *factoryLabel;
//  剂量
@property (nonatomic, strong) UILabel *doseLabel;
//  用法
@property (nonatomic, strong) UILabel *useLable;
//  备注
@property (nonatomic, strong) UILabel *descLabel;

@end
