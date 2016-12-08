//
//  CarBuyListCell.h
//  QuickPos
//
//  Created by Lff on 16/12/7.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarBuyListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *chooseBtn;//选择按钮
@property (weak, nonatomic) IBOutlet UIImageView *imageIcon;//图片
@property (weak, nonatomic) IBOutlet UILabel *titleLab;//标题lab
@property (weak, nonatomic) IBOutlet UILabel *moneyLab;//价格lab
@property (weak, nonatomic) IBOutlet UILabel *countLab;//数量lab



@end
