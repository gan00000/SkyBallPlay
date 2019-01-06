//
//  XJToastView.m
//  Exchange
//
//  Created by Marco on 2017/3/7.
//  Copyright © 2017年 zhugelicai. All rights reserved.
//

#import "XJToastView.h"

@interface XJToastView ()

@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation XJToastView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgView.layer.cornerRadius = 3;
    self.bgView.layer.masksToBounds = YES;
}

@end
