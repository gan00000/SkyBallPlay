//
//  HTNewsTopHeaderView.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/10.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "HTNewsTopHeaderView.h"

@interface HTNewsTopHeaderView ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation HTNewsTopHeaderView

- (void)skargrefreshWithTitle:(NSString *)title {
    self.titleLabel.text = title;
}

@end
