//
//  XJToastImageView.m
//  BenjiaPro
//
//  Created by Marco on 2017/9/5.
//  Copyright © 2017年 Benjia. All rights reserved.
//

#import "XJToastImageView.h"

@interface XJToastImageView ()

@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation XJToastImageView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgView.layer.cornerRadius = 3;
    self.bgView.layer.masksToBounds = YES;
}

@end
