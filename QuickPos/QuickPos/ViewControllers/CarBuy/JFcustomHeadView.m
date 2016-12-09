//
//  JFcustomHeadView.m
//  QuickPos
//
//  Created by Lff on 16/12/8.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "JFcustomHeadView.h"
@interface JFcustomHeadView(){
    NSString *nameTitle;
}
@end

@implementation JFcustomHeadView


- (instancetype)initWithFrame:(CGRect)frame titleName:(NSString*)name{
    self = [super initWithFrame:frame];
    if (self) {
        nameTitle = name;
        [self baseInit];
    }
    return self;
}

-(void)baseInit{
    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"JFcustomHeadView" owner:self options:nil];
    UIView *view = nil;
    for (id obj in arr) {
        if ([obj isKindOfClass:[UIView class]]) {
            view = obj;
            break;
        }
    }
    if (view != nil) {
        [self addSubview:view];
    }
}
- (void)layoutSubviews{
    self.frame = CGRectMake(0,0, NEWWIDTH, 40);
    self.backgroundColor = [UIColor whiteColor];
    _bgView.backgroundColor = [UIColor whiteColor];

}
-(void)awakeFromNib{
    [super awakeFromNib];
    _mallNameLab.text = @"123";
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
