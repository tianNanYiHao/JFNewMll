//
//  CarBuyHeadListCell.h
//  QuickPos
//
//  Created by Lff on 16/12/12.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JFShopCarModel;
@interface CarBuyHeadListCell : UITableViewCell

@property (nonatomic,strong) JFShopCarModel *model;

@property (weak, nonatomic) IBOutlet UIButton *selectedBtn;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLab;

@property (nonatomic,assign) BOOL isSelected;


@end
