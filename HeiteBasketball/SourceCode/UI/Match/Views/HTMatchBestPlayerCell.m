//
//  HTMatchBestPlayerCell.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/10/13.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "HTMatchBestPlayerCell.h"

@interface HTMatchBestPlayerCell ()

@property (weak, nonatomic) IBOutlet UILabel *homePtsLabel;
@property (weak, nonatomic) IBOutlet UILabel *homePtsPlayerLabel;
@property (weak, nonatomic) IBOutlet UILabel *homePtsPlaceLabel;
@property (weak, nonatomic) IBOutlet UILabel *homeAstLabel;
@property (weak, nonatomic) IBOutlet UILabel *homeAstPlayerLabel;
@property (weak, nonatomic) IBOutlet UILabel *homeAstPlaceLabel;
@property (weak, nonatomic) IBOutlet UILabel *homeRebLabel;
@property (weak, nonatomic) IBOutlet UILabel *homeRebPlayerLabel;
@property (weak, nonatomic) IBOutlet UILabel *homeRebPlaceLabel;

@property (weak, nonatomic) IBOutlet UILabel *awayPtsLabel;
@property (weak, nonatomic) IBOutlet UILabel *awayPtsPlayerLabel;
@property (weak, nonatomic) IBOutlet UILabel *awayPtsPlaceLabel;
@property (weak, nonatomic) IBOutlet UILabel *awayAstLabel;
@property (weak, nonatomic) IBOutlet UILabel *awayAstPlayerLabel;
@property (weak, nonatomic) IBOutlet UILabel *awayAstPlaceLabel;
@property (weak, nonatomic) IBOutlet UILabel *awayRebLabel;
@property (weak, nonatomic) IBOutlet UILabel *awayRebPlayerLabel;
@property (weak, nonatomic) IBOutlet UILabel *awayRebPlaceLabel;



@end

@implementation HTMatchBestPlayerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupWithMatchSummaryModel:(HTMatchSummaryModel *)summaryModel {
    self.homePtsLabel.text = summaryModel.home_team_pts_most.pts;
    self.homePtsPlayerLabel.text = summaryModel.home_team_pts_most.name;
    self.homePtsPlaceLabel.text = [NSString stringWithFormat:@"位置：%@", summaryModel.home_team_pts_most.position];
    
    
    self.homeAstLabel.text = summaryModel.home_team_ast_most.ast;
    self.homeAstPlayerLabel.text = summaryModel.home_team_ast_most.name;
    self.homeAstPlaceLabel.text = [NSString stringWithFormat:@"位置：%@", summaryModel.home_team_ast_most.position];
    
    self.homeRebLabel.text = summaryModel.home_team_reb_most.reb;
    self.homeRebPlayerLabel.text = summaryModel.home_team_reb_most.name;
    self.homeRebPlaceLabel.text = [NSString stringWithFormat:@"位置：%@", summaryModel.home_team_reb_most.position];
    
    self.awayPtsLabel.text = summaryModel.away_team_pts_most.pts;
    self.awayPtsPlayerLabel.text = summaryModel.away_team_pts_most.name;
    self.awayPtsPlaceLabel.text = [NSString stringWithFormat:@"位置：%@", summaryModel.away_team_pts_most.position];
    
    
    self.awayAstLabel.text = summaryModel.away_team_ast_most.ast;
    self.awayAstPlayerLabel.text = summaryModel.away_team_ast_most.name;
    self.awayAstPlaceLabel.text = [NSString stringWithFormat:@"位置：%@", summaryModel.away_team_ast_most.position];
    
    self.awayRebLabel.text = summaryModel.away_team_reb_most.reb;
    self.awayRebPlayerLabel.text = summaryModel.away_team_reb_most.name;
    self.awayRebPlaceLabel.text = [NSString stringWithFormat:@"位置：%@", summaryModel.away_team_reb_most.position];
}

@end
