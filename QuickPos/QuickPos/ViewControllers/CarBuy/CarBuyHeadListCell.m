//
//  CarBuyHeadListCell.m
//  QuickPos
//
//  Created by Lff on 16/12/12.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "CarBuyHeadListCell.h"
#import "JFShopCarModel.h"

@implementation CarBuyHeadListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(JFShopCarModel *)model{
    _model = model;
    _selectedBtn.selected = model.isSelected;
    _shopNameLab.text = model.store_name;
    
}



@end
