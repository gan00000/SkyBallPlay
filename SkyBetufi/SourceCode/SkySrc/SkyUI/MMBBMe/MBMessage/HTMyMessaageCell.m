//
//  HTMyMessaageCell.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2019/4/15.
//  Copyright © 2019 Dean_F. All rights reserved.
//

#import "HTMyMessaageCell.h"
#import "BJDateFormatUtility.h"

@interface HTMyMessaageCell ()

@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation HTMyMessaageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)skargrefreshWithMyMessageModel:(HTMyMessageModel *)model {
    self.descLabel.text = model.desc;
    self.contentLabel.text = model.reply_msg;
    self.titleLabel.text = model.post_title;
    self.timeLabel.text = [BJDateFormatUtility dateToShowFromDate:model.date];
}

@end
