//
//  HTNewsHomeCell.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/9.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "HTNewsHomeCell.h"

@interface HTNewsHomeCell ()

@property (weak, nonatomic) IBOutlet UIImageView *thumbImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *viewLabel;
@property (weak, nonatomic) IBOutlet UIView *shareButtonContentView;
@property (weak, nonatomic) IBOutlet UIImageView *view_icon;

@property (nonatomic, weak) HTNewsModel *newsModel;

@end

@implementation HTNewsHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if ([HTNewsModel canShare]) {
        self.shareButtonContentView.hidden = NO;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupWithNewsModel:(HTNewsModel *)newsModel {
    self.newsModel = newsModel;
    [self.thumbImageView sd_setImageWithURL:[NSURL URLWithString:newsModel.img_url] placeholderImage:HT_DEFAULT_IMAGE];
    self.titleLabel.text = newsModel.title;
    self.timeLabel.text = newsModel.time;
    self.viewLabel.text = newsModel.view_count;
    if (!newsModel.view_count.length) {
        self.view_icon.hidden = YES;
    }
}

- (IBAction)onShareButtonTapped:(id)sender {
    [self.newsModel share];
}

@end
