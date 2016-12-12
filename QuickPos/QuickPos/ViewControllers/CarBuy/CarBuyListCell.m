//
//  CarBuyListCell.m
//  QuickPos
//
//  Created by Lff on 16/12/7.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "CarBuyListCell.h"
#import "JFShopCarModel.h"

@implementation CarBuyListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//选中
- (IBAction)chooseBtn:(UIButton*)sender {
    CarBuyListCell *cell = (CarBuyListCell*)sender.superview.superview;
    if ([_delegate respondsToSelector:@selector(chooseBtnClickDelegate: model:)]) {
        [_delegate chooseBtnClickDelegate:sender model:cell.model];
    }
    
}

//-
- (IBAction)jianBtnClick:(id)sender {
    NSLog(@"----------");
    if ([_delegate respondsToSelector:@selector(jianBtnClickDelegate)]) {
        [_delegate jianBtnClickDelegate];
    }
    
}

//+
- (IBAction)jiaBtnClick:(id)sender {
     NSLog(@"+++++++");
    if ([_delegate respondsToSelector:@selector(jiaBtnClickDelegate)]) {
        [_delegate jiaBtnClickDelegate];
    }
    
}

- (void)setModel:(JFShopCarModel *)model{
    _model = model;
    _chooseBtn.selected = model.isSelected;
    
}


@end
