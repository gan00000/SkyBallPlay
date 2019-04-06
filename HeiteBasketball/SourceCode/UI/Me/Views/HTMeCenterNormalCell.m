//
//  HTMeCenterNormalCell.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2019/4/5.
//  Copyright © 2019 Dean_F. All rights reserved.
//

#import "HTMeCenterNormalCell.h"

@interface HTMeCenterNormalCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation HTMeCenterNormalCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}

@end
