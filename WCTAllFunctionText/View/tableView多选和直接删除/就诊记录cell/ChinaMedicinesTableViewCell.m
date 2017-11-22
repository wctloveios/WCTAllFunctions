//
//  ChinaMedicinesTableViewCell.m
//  PalmDoctor
//
//  Created by four on 16/2/5.
//  Copyright © 2016年 km. All rights reserved.
//

#import "ChinaMedicinesTableViewCell.h"

@implementation ChinaMedicinesTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, 20)];
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView  addSubview:_nameLabel];
        
        _doseLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, MainScreenWidth/2, 20)];
        _doseLabel.font = [UIFont systemFontOfSize:14];
        _doseLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView  addSubview:_doseLabel];
        
        _useLable = [[UILabel alloc]initWithFrame:CGRectMake(MainScreenWidth/2, 20,  MainScreenWidth/2, 20)];
        _useLable.font = [UIFont systemFontOfSize:14];
        _useLable.textAlignment = NSTextAlignmentLeft;
        [self.contentView  addSubview:_useLable];
    
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
