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
    
    self.winLabel.text = rankModel.wins;
    self.loseLabel.text = rankModel.losses?:rankModel.Losses;
    self.winRateLabel.text = [NSString stringWithFormat:@"%.1f%%", rankModel.winRate];
    self.homeLabel.text = [NSString stringWithFormat:@"%@-%@", rankModel.homewin, rankModel.homelose];
    self.awayLabel.text = [NSString stringWithFormat:@"%@-%@", rankModel.awaywin, rankModel.awaylose];
    self.areaLabel.text = [NSString stringWithFormat:@"%ld-%ld", rankModel.homewin.integerValue + rankModel.awaywin.integerValue, rankModel.homelose.integerValue + rankModel.awaylose.integerValue];
    if (rankModel.GamesPlayed) {
        self.ptsLabel.text = [NSString stringWithFormat:@"%.1f", 1.0 * rankModel.pts.integerValue / rankModel.GamesPlayed.integerValue];
        self.losePtsLabel.text = [NSString stringWithFormat:@"%.1f", 1.0 * rankModel.PtsAgainst.integerValue / rankModel.GamesPlayed.integerValue];
    } else {
        self.ptsLabel.text = [NSString stringWithFormat:@"%.1f", 1.0 * rankModel.pts.integerValue / rankModel.gamesplayed.integerValue];
        self.losePtsLabel.text = [NSString stringWithFormat:@"%.1f", 1.0 * rankModel.ptsagainst.integerValue / rankModel.gamesplayed.integerValue];
    }
    
    
    self.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"FFFFFF"];
    if (row % 2 == 1) {
        self.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"f4f7f0"];
    }
}

@end
