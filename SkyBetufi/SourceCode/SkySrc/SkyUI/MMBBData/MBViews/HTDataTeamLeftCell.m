//
//  HTDataTeamLeftCell.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/10/19.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "HTDataTeamLeftCell.h"

@interface HTDataTeamLeftCell ()

@property (weak, nonatomic) IBOutlet UILabel *orderLabel;
@property (weak, nonatomic) IBOutlet UILabel *teamNameLabel;

@end

@implementation HTDataTeamLeftCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)skargrefreshWithTeamModel:(HTDataTeamRankModel *)teamModel row:(NSInteger)row {
    
    self.orderLabel.text = [NSString stringWithFormat:@"%ld", row + 1];
    self.teamNameLabel.text = teamModel.teamName;
    
    self.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"FFFFFF"];
    if (row % 2 == 1) {
        self.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"f4f7f0"];
    }
}

@end
