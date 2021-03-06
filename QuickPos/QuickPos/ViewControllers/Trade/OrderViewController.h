//
//  OrderViewController.h
//  QuickPos
//
//  Created by 胡丹 on 15/3/18.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import <UIKit/UIKit.h>


@class HandSignViewController;
#import "OrderData.h"

@protocol getOrderTypeProtocol <NSObject>
- (void)getOrderType:(BOOL)orderType;
- (void)getOrderId:(NSString *)orderId;
@end



@interface OrderViewController : UIViewController


@property (nonatomic,strong) NSString *ReceivablesName;//收款人姓名
@property (nonatomic,strong) NSString *ReceivablesPhoneNo;//收款人手机号
@property (nonatomic,strong) NSString *ReceivablesCardNo;//收款人账号

@property (nonatomic,strong)OrderData *orderData;
@property (nonatomic,strong)HandSignViewController *handSignViewController;
@property (nonatomic, copy) NSString *printInfo;
@property (nonatomic,retain)NSObject<getOrderTypeProtocol>*delegate;



@end
