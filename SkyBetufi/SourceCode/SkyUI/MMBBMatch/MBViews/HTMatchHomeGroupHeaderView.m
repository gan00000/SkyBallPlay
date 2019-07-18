//
//  HTMatchHomeGroupHeaderView.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/9.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "HTMatchHomeGroupHeaderView.h"

@interface HTMatchHomeGroupHeaderView ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation HTMatchHomeGroupHeaderView

- (void)setName:(NSString *)name {
    self.nameLabel.text = name;
}

@end
