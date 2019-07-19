//
//  HTRankLeftCell.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/10/18.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "HTRankLeftCell.h"

@interface HTRankLeftCell ()

@property (weak, nonatomic) IBOutlet UILabel *rankLabel;
@property (weak, nonatomic) IBOutlet UILabel *teamNameLabel;

@end

@implementation HTRankLeftCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)refreshWithRankModel:(HTRankModel *)rankModel row:(NSInteger)row {
    
    self.rankLabel.text = [NSString stringWithFormat:@"%ld", row+1];
    self.teamNameLabel.text = rankModel.teamName;
    
    self.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"FFFFFF"];
    if (row % 2 == 1) {
        self.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"f4f7f0"];
    }
}

@end
