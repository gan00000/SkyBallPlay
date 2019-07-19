//
//  HTNewsHeaderCell.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/10.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "HTNewsHeaderCell.h"

@interface HTNewsHeaderCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *viewCountLabel;


@end

@implementation HTNewsHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupWithNewsModel:(HTNewsModel *)newsModel {
    self.titleLabel.text = newsModel.title;
    self.timeLabel.text = newsModel.time;
    self.viewCountLabel.text = newsModel.view_count;
}

@end
