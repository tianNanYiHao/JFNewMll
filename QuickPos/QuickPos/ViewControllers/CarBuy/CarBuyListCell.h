//
//  CarBuyListCell.h
//  QuickPos
//
//  Created by Lff on 16/12/7.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CarBuyListCellDelegate<NSObject>
-(void)chooseBtnClickDelegate:(UIButton*)btn index:(NSIndexPath*)indexPath;
-(void)jianBtnClickDelegate;
-(void)jiaBtnClickDelegate;

@end

@interface CarBuyListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *chooseBtn;//选择按钮
@property (weak, nonatomic) IBOutlet UIImageView *imageIcon;//图片
@property (weak, nonatomic) IBOutlet UILabel *titleLab;//标题lab
@property (weak, nonatomic) IBOutlet UILabel *moneyLab;//价格lab

@property (weak, nonatomic) IBOutlet UIButton *jianBtn; //-
@property (weak, nonatomic) IBOutlet UILabel *countLab; //数量
@property (weak, nonatomic) IBOutlet UIButton *jiaBtn; //+
@property (nonatomic,assign) NSIndexPath *path;
@property (nonatomic,assign) id<CarBuyListCellDelegate> delegate;
@property (nonatomic,assign) BOOL isSelected;


@end
