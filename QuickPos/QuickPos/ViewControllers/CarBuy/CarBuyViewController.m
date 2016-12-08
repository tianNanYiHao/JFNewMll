//
//  CarBuyViewController.m
//  QuickPos
//
//  Created by Lff on 16/12/7.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "CarBuyViewController.h"
#import "CarBuyListCell.h"
#import "JFcustomHeadView.h"

@interface CarBuyViewController ()<UITableViewDelegate,UITableViewDataSource>
{
//    JFcustomHeadView *jfheadView;
}
@property (weak, nonatomic) IBOutlet UITableView *tableShowView;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;//结算按钮
@property (weak, nonatomic) IBOutlet UILabel *moneyShowLab;//金额Lab

@end

@implementation CarBuyViewController
//结算点击事件
- (IBAction)buyBtnClick:(id)sender {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"购物车";
    self.view.backgroundColor = [Common hexStringToColor:@"ECEBF5"];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [Common hexStringToColor:@"#068bf4"];//导航栏颜色
    self.navigationController.navigationBar.tintColor = [Common hexStringToColor:@"#ffffff"];//返回键颜色
    self.navigationController.navigationBar.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self createTableView];
}

-(void)createTableView
{
    _tableShowView.delegate = self;
    _tableShowView.dataSource = self;
    _tableShowView.backgroundColor = [Common hexStringToColor:@"ECEBF5"];
    [_tableShowView registerNib:[UINib nibWithNibName:@"CarBuyListCell" bundle:nil] forCellReuseIdentifier:@"CarBuyListCell"];
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    if (section == 0) {
//     JFcustomHeadView *jfheadView = [[JFcustomHeadView alloc] initWithFrame:CGRectZero] ;
//        jfheadView.mallName = @"百步生活1";
//        return jfheadView;
//    }else if (section == 1){
//        JFcustomHeadView *jfheadView = [[JFcustomHeadView alloc] initWithFrame:CGRectZero];
//        jfheadView.mallName = @"百步生活2";
//        return jfheadView;
//    }else if (section ==2 ){
//        JFcustomHeadView *jfheadView = [[JFcustomHeadView alloc] initWithFrame:CGRectZero];
//        jfheadView.mallName = @"百步生活3";
//        return jfheadView;
//    }else {
//        return nil;
//    }
    
    JFcustomHeadView *jfheadView = [[JFcustomHeadView alloc] initWithFrame:CGRectZero titleName:@"百步生活"];
    return jfheadView;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, NEWWIDTH, 15)];
    bgView.backgroundColor = [Common hexStringToColor:@"ECEBF5"];
    return bgView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 15;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
   else if (section == 1) {
        return 2;
    }
   else if (section == 2) {
        return 3;
    }else{
         return 0;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"CarBuyListCell";
    CarBuyListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        NSLog(@"1111");
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
