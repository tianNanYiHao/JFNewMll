//
//  JFcustomHeadView.h
//  QuickPos
//
//  Created by Lff on 16/12/8.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol JFcustomHeadViewDelegate<NSObject>
-(void)JFcustomHeadViewChooseBtnClick:(UIButton*)btn;

@end

@interface JFcustomHeadView : UIView
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIButton *btnChoose;
@property (weak, nonatomic) IBOutlet UILabel *mallNameLab;
@property (nonatomic,assign)id<JFcustomHeadViewDelegate>delegate;
@property (nonatomic,strong)    NSString * mallName;
//- (instancetype)initWithFrame:(CGRect)frame titleName:(NSString*)name;
+(instancetype)viewWithTitlaName:(NSString*)name;



@end
