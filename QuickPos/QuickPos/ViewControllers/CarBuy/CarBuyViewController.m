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
#import "JFShopCarModel.h"

@interface CarBuyViewController ()<UITableViewDelegate,UITableViewDataSource,CarBuyListCellDelegate,JFcustomHeadViewDelegate>
{
    JFcustomHeadView *jfheadView;
    CarBuyListCell *cell;
    
}
@property (nonatomic,strong) NSMutableArray *arrSection;
@property (nonatomic,strong) JFShopCarModel *model;

@property (weak, nonatomic) IBOutlet UITableView *tableShowView;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;//结算按钮
@property (weak, nonatomic) IBOutlet UILabel *moneyShowLab;//金额Lab

@end

@implementation CarBuyViewController
/**
 店铺名称数组
 */
-(NSMutableArray*)arrSection{
    if (!_arrSection) {
        _arrSection = [NSMutableArray arrayWithCapacity:0];
    }
    return _arrSection;
}
-(JFShopCarModel *)model{
    if (!_model) {
        _model = [[JFShopCarModel alloc] init];
    }
    return _model;
}


//结算点击事件
- (IBAction)buyBtnClick:(UIButton*)sender {
    
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
    [self setModel];
    [self createTableView];
}

-(void)setModel{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"shoppingCar" ofType:@"plist"];
    NSArray *arr = [[NSArray alloc] initWithContentsOfFile:path];
    self.arrSection = (NSMutableArray*)arr;
    
}

-(void)createTableView
{
    _tableShowView.delegate = self;
    _tableShowView.dataSource = self;
    _tableShowView.backgroundColor = [Common hexStringToColor:@"ECEBF5"];
    [_tableShowView registerNib:[UINib nibWithNibName:@"CarBuyListCell" bundle:nil] forCellReuseIdentifier:@"CarBuyListCell"];
    
}
#pragma mark - tableviewDelegate
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    static NSString *IDD = @"dddd";
    UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:IDD];
    if (!view) {
        view = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:IDD];
        if (section == 0) {
            jfheadView = [JFcustomHeadView viewWithTitlaName:@"百步商城"];
            jfheadView.delegate = self;
            [view addSubview:jfheadView];
        }
        else if (section == 1) {
            jfheadView = [JFcustomHeadView viewWithTitlaName:@"淘五金商城"];
            jfheadView.delegate = self;
            [view addSubview:jfheadView];
        }
        else if (section == 2) {
            jfheadView = [JFcustomHeadView viewWithTitlaName:@"我的商城"];
            jfheadView.delegate = self;
            [view addSubview:jfheadView];
        }
      
    }
      return view;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, NEWWIDTH, 15)];
    bgView.backgroundColor = [Common hexStringToColor:@"ECEBF5"];
    return bgView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.arrSection.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 15;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if (section == 0) {
//        return [self.arrSection[0] count];
//    }
//   else if (section == 1) {
//        return [self.arrSection[1] count];
//    }
//   else if (section == 2) {
//        return [self.arrSection[2] count];
//    }
         return [_arrSection[section] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"CarBuyListCell";
    cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *arr = self.arrSection[indexPath.section];
    self.model = arr[indexPath.row];
    cell.delegate = self;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}
#pragma mark - CarBuyListDelete
-(void)chooseBtnClickDelegate:(UIButton *)btn model:(JFShopCarModel *)model{

}
-(void)jianBtnClickDelegate{
    NSLog(@"lalallal -------");
}
-(void)jiaBtnClickDelegate{
    NSLog(@"lalalal ++++");
}

#pragma mark - JFcustomHeadviewDelegate
-(void)JFcustomHeadViewChooseBtnClick:(UIButton *)btn{
    btn.selected = !btn.selected;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
