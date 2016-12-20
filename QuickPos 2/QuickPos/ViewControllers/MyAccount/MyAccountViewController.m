//
//  MyAccountViewController.m
//  YoolinkIpos
//
//  Created by 张倡榕 on 15/3/4.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "MyAccountViewController.h"
#import "MyAccountHeaderTableViewCell.h"
#import "MyAccountTableViewCell.h"
#import "PerfectInformationViewController.h"
#import "WithdrawalViewController.h"
#import "TransactionRecordsViewController.h"
#import "MyCreditCardMachineViewController.h"
#import "DDMenuController.h"
#import "QuickPosTabBarController.h"
#import "MyMessageViewController.h"
#import "MyChangePasswordViewController.h"
#import "PayType.h"
#import "UserInfo.h"
#import "Common.h"
#import "CodeView.h"
#import "LoginViewController.h"
#import "MyAccount2TableViewCell.h"
#import "HelpViewController.h"
#import "InstructionsForUseViewController.h"
#import "MyRunSubWithdrawViewController.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+Add.h"
#import "MyImessageViewController.h"
#import "customBtn.h"

@interface MyAccountViewController ()<UITableViewDataSource,UITableViewDelegate,ResponseData,UIAlertViewDelegate,getRespDesc>{
    
    NSDictionary *dataDic;//金额的字典
    
    NSDictionary *UserdataDic;//用户的字典
    
    NSString *availableAmtStr;//账户余额
    
    NSString *cashAvailableAmtStr;//可提现余额
    
    NSString *immCashAmt;//T+0提现余额
    
    NSString *agentAmt;//我的分润
    
    NSString *UserTypes;// userType = 0 说明是代理商,显示我的分润,userType = 1说明不是代理商
    
    NSString *realNameStr;//用来取用户名
    
    Request *requst;
    
    NSUserDefaults *userDefaults;//存取
    
    NSString *state;//认证状态
    
    NSString *stateRemake; //返回未通过状态
    
    NSString *picStr;//头像str
    
    UIImage *image;//GCD头像用
    
    NSData *data;//GCD转换数据库的头像用
    
    NSString *ID;//身份证
    
    UserInfo *info;
}
@property (nonatomic ,strong)CodeView *codeView;
@property (weak, nonatomic) IBOutlet UITableView *myAccountTableView;//tableview

@property (weak, nonatomic) IBOutlet UIView *OutFootView;//tableview尾view
@property (weak, nonatomic) IBOutlet UIButton *tuichu;

@property (weak, nonatomic) IBOutlet UIButton *ShopManagement;//店铺管理


@property (nonatomic,strong) NSString *agentNum;//用户数目
@property (nonatomic,strong) NSString *agentRate;//分润比例

@property (nonatomic,strong) NSString *authenFlag;


@end

@implementation MyAccountViewController
@synthesize codeView;

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    self.navigationController.navigationBar.barTintColor = [Common hexStringToColor:@"4a4848"];
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = L(@"MyAccount");
    
    availableAmtStr = @"0.00";
    cashAvailableAmtStr = @"0.00";
    immCashAmt = @"0.00";
    
    self.navigationController.navigationBar.barTintColor = [Common hexStringToColor:@"#068bf4"];//导航栏颜色
    self.navigationController.navigationBar.tintColor = [Common hexStringToColor:@"#ffffff"];//返回键颜色
    self.navigationController.navigationBar.contentMode = UIViewContentModeScaleAspectFit;
    //设置标题颜色
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [Common hexStringToColor:@"#ffffff"], UITextAttributeTextColor,
                                                                     [UIFont systemFontOfSize:17], UITextAttributeFont,
                                                                     nil]];
    
    
    //右上角点击按钮
//    [self creatRightBtn];
    

    userDefaults = [NSUserDefaults standardUserDefaults];
    
    self.navigationController.navigationBarHidden = NO;
    
    self.tabBarController.tabBar.hidden = NO;
    
    [Common setExtraCellLineHidden:self.myAccountTableView];//去除多余的线
    
    self.myAccountTableView.delaysContentTouches = NO; //值为NO时，UIScrollView会立马将接收到的手势分发到子视图上。
    
    [self.myAccountTableView registerNib:[UINib nibWithNibName:@"MyAccount2TableViewCell" bundle:nil] forCellReuseIdentifier:@"MyAccount2TableViewCell"];
    //self.myAccountTableView.separatorStyle = NO;
    self.myAccountTableView.tableFooterView = self.OutFootView;
    
    requst = [[Request alloc]initWithDelegate:self];
    
    
    self.tuichu.backgroundColor = [UIColor whiteColor];

    
 
    self.OutFootView.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

- (void)creatRightBtn
{
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [rightBtn setImage:[UIImage imageNamed:@"serve_more"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];

    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)rightBtn:(UIButton *)btn
{
    [(DDMenuController*)[(QuickPosTabBarController*)self.tabBarController parentCtrl] showRightController:YES];
    
}


- (IBAction)showSetup:(UIBarButtonItem *)sender {
    [(DDMenuController *)[(QuickPosTabBarController *)self.tabBarController parentCtrl] showRightController:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[Common createImageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:[Common createImageWithColor:[UIColor clearColor]]];
    [self.navigationController.navigationBar setShadowImage:[Common createImageWithColor:[UIColor clearColor]]];
    
    

    self.tabBarController.tabBar.hidden = NO;
    
    dataDic = [NSMutableDictionary dictionary];
    
    //登陆判断
    if ([[AppDelegate getUserBaseData].mobileNo length] > 0) {

        //已经登陆
        [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"加载中."];

//        [requst getVirtualAccountBalance:@"00" token:[AppDelegate getUserBaseData].token];
        [requst userInfo:[AppDelegate getUserBaseData].mobileNo];
        
    }else{
        
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginViewController *login = [storyBoard instantiateViewControllerWithIdentifier:@"QuickPosNavigationController"];
        [self presentViewController:login animated:YES completion:nil];
    }

}




- (void)responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type{
    
    if(type == REQUSET_USERINFOQUERY && [dict[@"respCode"] isEqual:@"0000"]){
        
        NSMutableDictionary *getDic = [NSMutableDictionary dictionary];
        
        getDic = dict[@"data"];
        
        info = [[UserInfo alloc]initWithData:getDic[@"resultBean"]];
        
        self.authenFlag = [[[dict objectForKey:@"data"]objectForKey:@"resultBean"]objectForKey:@"authenFlag"];
        
        if ([self.authenFlag isEqualToString:@"0"]) {
            realNameStr = @"立即登录";
            state = info.authenFlag;
            stateRemake = info.remark;
            picStr = info.pic;
            ID = info.certPid;
            [self.myAccountTableView reloadData];
            
            //GCD操作
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                // 耗时的操作
                
                image = [UIImage imageWithData:[self headImage:picStr]];
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    // 更新界面
                    //[self.myAccountTableView reloadData];
                    
                });
            });
        }else{
            realNameStr = info.realName;
            state = info.authenFlag;
            stateRemake = info.remark;
            picStr = info.pic;
            ID = info.certPid;
            [self.myAccountTableView reloadData];
            
            //GCD操作
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                // 耗时的操作
                
                image = [UIImage imageWithData:[self headImage:picStr]];
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    // 更新界面
                    //[self.myAccountTableView reloadData];
                    
                });
            });        }
        
        
    }
    
    
//    if(type == REQUEST_ACCTENQUIRY && [dict[@"respCode"] isEqual:@"0000"] ){
//        
//        dataDic = dict;
//        
//        double userSum = [[dataDic objectForKey:@"availableAmt"] doubleValue];
//        double withdrawSum = [[dataDic objectForKey:@"cashAvailableAmt"] doubleValue];
//        double CashAmt = [[dataDic objectForKey:@"immCashAmt"]doubleValue];
//        double agent = [[dataDic objectForKey:@"agentAmt"]doubleValue];
//        UserTypes = [dataDic objectForKey:@"userType"];
//        self.agentNum = [dataDic objectForKey:@"agentNum"];
//        double agentRt = [[dataDic objectForKey:@"agentRate"]doubleValue];
//        
//        
//        NSLog(@"%@",UserTypes);
//        availableAmtStr = [NSString stringWithFormat:@"%0.2f",userSum/100];
//        cashAvailableAmtStr = [NSString stringWithFormat:@"%0.2f",withdrawSum/100];
//        immCashAmt = [NSString stringWithFormat:@"%0.2f",CashAmt/100];
//        agentAmt = [NSString stringWithFormat:@"%0.2f",agent/100];
//        self.agentRate = [NSString stringWithFormat:@"%0.2f",agentRt/100];
//        
//        
//        NSLog(@"%f  %@",agentRt,self.agentRate);
//        
//        
//        if(availableAmtStr == nil){
//            
//            availableAmtStr = @"0.00";
//            
//        }else if (cashAvailableAmtStr == nil){
//            
//            cashAvailableAmtStr = @"0.00";
//            
//        }
//        
//        [self.myAccountTableView reloadData];
//        
//    }
    if(type == REQUEST_QUICKPAYSTATE && [dict[@"respCode"] isEqual:@"0000"] ){
        
        NSString *message = [[[dict objectForKey:@"data"] objectForKey:@"result"] objectForKey:@"resultCode"];
        if ([message isEqualToString:@"8895"]) {
            [CodeView showVersionView:self lab:L(@"NoRecord")];
        }
        else
        {
            [CodeView showVersionView:self lab:[[dict objectForKey:@"data"] objectForKey:@"psamid"]];
        }
        
        
    }
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

#pragma mark - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(section == 0){
        return 1;
        
    }
    if (section == 1){
        return 1;
    }
    if (section == 2) {
        return 1;
    }

    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1 || section == 0) {
        return 0;
    }else{
        return 0;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
        return 98;
    }
    else if (section == 4) {
        return 10;
    }else{
        return 10;
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0){
        
        return 130;
        
    }
    
    if(indexPath.section == 1 && indexPath.row == 1){
    
        return 44;
        
    }
    return 44;
}





- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //头像cell
    if(indexPath.section == 0){
        
        static NSString *headerCellCellIdentifier = @"MyAccountHeaderCell";
        
        MyAccountHeaderTableViewCell *headerCell =(MyAccountHeaderTableViewCell *) [tableView dequeueReusableCellWithIdentifier:headerCellCellIdentifier];
        
        headerCell.backgroundColor = [Common hexStringToColor:@"#068bf4"];
        
        headerCell.usernameLabel.text = realNameStr;
        headerCell.moneyLabel.text = availableAmtStr;
        headerCell.withdrawalLabel.text = cashAvailableAmtStr;
        headerCell.AccountBalance.text = [NSString stringWithFormat:@"%@元",availableAmtStr];
        headerCell.RunSubBalance.text = [NSString stringWithFormat:@"%@元",availableAmtStr];
        headerCell.Balance.text = [NSString stringWithFormat:@"%@元",immCashAmt];
        
        headerCell.selectionStyle = UITableViewCellSelectionStyleNone;
        headerCell.headicon.image = [UIImage imageNamed:@"account_Avatar"];
        headerCell.contentView.backgroundColor = [UIColor colorWithRed:63/255.0 green:146/255.0 blue:236/255.0 alpha:1];
        return headerCell;
    }
    
    
    //列表cell绑定
    static NSString *CellIdentifier = @"MyAccountCell";
    
    MyAccountTableViewCell *cell = (MyAccountTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (indexPath.section == 1) {
            if (indexPath.row == 0){
                
                MyAccountTableViewCell *cell3 = (MyAccountTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                cell3.titleLabel.text = @"我的订单";
                cell3.titleLabel2.text = @"查看所有订单";
                
                
                
                cell3.userInteractionEnabled = YES;
                cell3.UserQuantityLabel.hidden = YES;
                cell3.Quantity.hidden = YES;
                cell3.RunSubLabel.hidden = YES;
                cell3.RunSub.hidden = YES;
                cell3.lineView.hidden = YES;
                cell3.logoImageView.image = [UIImage imageNamed:@"account_available"];
                cell3.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//带箭头
//                cell3.accessoryType = UITableViewCellAccessoryNone;//取消箭头
                return cell3;
               
                
            }
    }
    if (indexPath.section == 2) {

        if (indexPath.row == 0){
            
            cell.titleLabel.text = @"收货地址";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.logoImageView.image = [UIImage imageNamed:@"account_trading"];
            cell.userInteractionEnabled = YES;
            cell.UserQuantityLabel.hidden = YES;
            cell.Quantity.hidden = YES;
            cell.RunSubLabel.hidden = YES;
            cell.RunSub.hidden = YES;
            cell.lineView.hidden = YES;
            
        }
    }

    return cell;
    
}
//点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    
}

- (IBAction)OutAct:(UIButton *)sender {
    
    NSLog(@"退出了");
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:L(@"ExitLogin") delegate:self cancelButtonTitle:L(@"cancel") otherButtonTitles:L(@"sure"), nil];
    
    [alert show];
    
}

//店铺管理


- (IBAction)shopManagement:(UIButton *)sender {
}


//UIalert... 代理
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(buttonIndex == 1){
        [[QuickPosTabBarController getQuickPosTabBarController] gotoLoginViewCtrl];
    }
}

//设置footerView
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    

    
    UIView *sectionFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 414, 5)];
    sectionFooterView.backgroundColor = [UIColor clearColor];
    if(section == 0){
        
        return sectionFooterView;
        
    }else if(section == 1){
    
        UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 1, 320, 88)];
        view1.backgroundColor = [UIColor whiteColor];
        
        UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 1, 159,68)];
        [btn1 setImage:[UIImage imageNamed:@"wait_ship"] forState:UIControlStateNormal];
        [btn1 addTarget:self action:@selector(waitShip:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 68, 159, 10)];
        label1.text = @"待收货";
        label1.font = [UIFont systemFontOfSize:14];
        label1.textColor = [UIColor lightGrayColor];
        label1.textAlignment = NSTextAlignmentCenter;
        [view1 addSubview:label1];
        [view1 addSubview:btn1];
        
        UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(160, 1, 161, 68)];
        [btn2 setImage:[UIImage imageNamed:@"wait_receipt"] forState:UIControlStateNormal];
         [btn2 addTarget:self action:@selector(waitReceipt:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(160, 68, 159, 10)];
        label2.text = @"待发货";
        label2.font = [UIFont systemFontOfSize:14];
        label2.textColor = [UIColor lightGrayColor];
        label2.textAlignment = NSTextAlignmentCenter;
        [view1 addSubview:btn2];
        [view1 addSubview:label2];
    
    //vertical_line
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(159, 0, 1, 88)];
        imageView.image = [UIImage imageNamed:@"vertical_line"];
        [view1 addSubview:imageView];
    
        [sectionFooterView addSubview:view1];
        return sectionFooterView;
    }

    return sectionFooterView;
}

//待发货点击方法
- (void)waitShip:(UIButton *)btn
{
    NSLog(@"<<<待发货>>>");
}
//待收货点击方法
- (void)waitReceipt:(UIButton *)btn
{
    NSLog(@"<<<待收货>>>");
}

//imagedata解压
- (NSData *)headImage:(NSString *)icon{
    
    int len = [icon length] / 2;    // Target length
    unsigned char *buf = malloc(len);
    unsigned char *whole_byte = buf;
    char byte_chars[3] = {'\0','\0','\0'};
    
    int i;
    for (i=0; i < [icon length]/ 2; i++) {
        byte_chars[0] = [icon characterAtIndex:i*2];
        byte_chars[1] = [icon characterAtIndex:i*2+1];
        *whole_byte = strtol(byte_chars, NULL, 16);
        whole_byte++;
    }
    
    data = [NSData dataWithBytes:buf length:len];
    
    
    return data;
}

- (void)getRespDesc:(NSString *)desc
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:desc message:nil delegate:self cancelButtonTitle:L(@"sure") otherButtonTitles:nil, nil];
    [alert show];
}



@end
 
