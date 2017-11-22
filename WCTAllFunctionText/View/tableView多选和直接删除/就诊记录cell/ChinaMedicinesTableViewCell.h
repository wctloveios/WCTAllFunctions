//
//  ChinaMedicinesTableViewCell.h
//  PalmDoctor
//
//  Created by four on 16/2/5.
//  Copyright © 2016年 km. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChinaMedicinesTableViewCell : UITableViewCell


// 药名
@property (nonatomic, strong) UILabel *nameLabel;
// 剂量
@property (nonatomic, strong) UILabel *doseLabel;
// 用法
@property (nonatomic, strong) UILabel *useLable;

@end
