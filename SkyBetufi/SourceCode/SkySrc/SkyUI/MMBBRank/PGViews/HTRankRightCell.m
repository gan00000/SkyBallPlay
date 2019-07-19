//
//  HTRankRightCell.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/10/18.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "HTRankRightCell.h"

@interface HTRankRightCell ()

@property (weak, nonatomic) IBOutlet UILabel *winLabel;
@property (weak, nonatomic) IBOutlet UILabel *loseLabel;
@property (weak, nonatomic) IBOutlet UILabel *winRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *homeLabel;
@property (weak, nonatomic) IBOutlet UILabel *awayLabel;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (weak, nonatomic) IBOutlet UILabel *ptsLabel;
@property (weak, nonatomic) IBOutlet UILabel *losePtsLabel;

@end

@implementation HTRankRightCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)refreshWithRankModel:(HTRankModel *)rankModel row:(NSInteger)row {
    
    self.winLabel.text = rankModel.win;
    self.loseLabel.text = rankModel.loss;
    self.winRateLabel.text = rankModel.winRate;
    self.homeLabel.text = rankModel.home_matches;
    self.awayLabel.text = rankModel.away_matches;
    self.areaLabel.text = rankModel.area_matches;
    self.ptsLabel.text = rankModel.avg_pts;
    self.losePtsLabel.text = rankModel.avg_against_pts;
        
    self.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"FFFFFF"];
    if (row % 2 == 1) {
        self.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"f4f7f0"];
    }
}

@end
