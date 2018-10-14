//
//  HTRankHomeCell.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/13.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "HTRankHomeCell.h"

@interface HTRankHomeCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *customContentView;

@end

@implementation HTRankHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupWithTitle:(NSString *)title rankList:(NSArray<HTRankModel *> *)rankList {
    self.titleLabel.text = title;
    
}

@end
