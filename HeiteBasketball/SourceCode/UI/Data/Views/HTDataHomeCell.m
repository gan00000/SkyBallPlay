//
//  HTDataHomeCell.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/13.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "HTDataHomeCell.h"

@interface HTDataHomeCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;
@property (weak, nonatomic) IBOutlet UIStackView *stackContentView;


@end

@implementation HTDataHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.arrowImageView.image = [self.arrowImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupWithTitle:(NSString *)title datas:(NSArray<HTDataHomeModel *> *)datas {
    self.titleLabel.text = title;
}

- (IBAction)onDetailButtonTapped:(UIButton *)sender {
    if (self.showMoreBlock) {
        self.showMoreBlock();
    }
}



@end
