//
//  customBtn.m
//  QuickPos
//
//  Created by Lff on 16/12/8.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "customBtn.h"

@implementation customBtn


-(void)layoutSubviews{

    self.imageView.frame = CGRectMake(0, 0, self.bounds.size.width/2, self.bounds.size.height-20);
    self.titleLabel.frame = CGRectMake(0, self.bounds.size.height-20,  self.bounds.size.width, 20);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
