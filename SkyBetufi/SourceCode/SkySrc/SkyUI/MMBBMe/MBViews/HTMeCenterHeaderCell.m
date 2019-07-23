//
//  HTMeCenterHeaderCell.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2019/4/5.
//  Copyright © 2019 Dean_F. All rights reserved.
//

#import "HTMeCenterHeaderCell.h"

@interface HTMeCenterHeaderCell ()

@property (weak, nonatomic) IBOutlet UIView *userInfoContentView;
@property (weak, nonatomic) IBOutlet JXImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet JXButton *loginButton;


@end

@implementation HTMeCenterHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)refreshUI {
    if ([HTUserManager skarg_isUserLogin]) {
        self.userInfoContentView.hidden = NO;
        self.loginButton.hidden = YES;
        self.avatarImageView.image = [HTUserManager skarg_userInfo].avatar;
        self.userNameLabel.text = [HTUserManager skarg_userInfo].display_name;
    } else {
        self.userInfoContentView.hidden = YES;
        self.loginButton.hidden = NO;
    }
}

- (IBAction)loginAction:(id)sender {
    [HTUserManager skarg_doUserLogin];
}


@end
