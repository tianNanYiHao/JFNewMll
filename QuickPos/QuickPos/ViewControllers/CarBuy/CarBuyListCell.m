//
//  CarBuyListCell.m
//  QuickPos
//
//  Created by Lff on 16/12/7.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "CarBuyListCell.h"

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
- (IBAction)chooseBtn:(id)sender {
    if ([_delegate respondsToSelector:@selector(chooseBtnClickDelegate:)]) {
        [_delegate chooseBtnClickDelegate:sender];
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






@end
