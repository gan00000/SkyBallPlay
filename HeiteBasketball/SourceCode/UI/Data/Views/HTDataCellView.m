//
//  HTDataCellView.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/13.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "HTDataCellView.h"
#import <WebKit/WebKit.h>

@interface HTDataCellView ()

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *teamNameLabel;

@property (nonatomic, strong) WKWebView *teamLogoWeb;

@end

@implementation HTDataCellView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self addSubview:self.teamLogoWeb];
    [self.teamLogoWeb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_offset(0);
    }];
}

- (void)setupWithDataModel:(HTDataHomeModel *)dataModel {
    self.scoreLabel.text = [NSString stringWithFormat:@"%.1f", dataModel.score];
    self.nameLabel.text = dataModel.name;
    self.teamNameLabel.text = dataModel.teamName;
    
    self.imageView.hidden = YES;
    self.teamLogoWeb.hidden = YES;
    if (dataModel.officialImagesrc.length > 0) {
        self.imageView.hidden = NO;
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:dataModel.officialImagesrc]
                          placeholderImage:HT_DEFAULT_IMAGE];
    } else if (dataModel.html_team_logo.length > 0) {
        self.teamLogoWeb.hidden = NO;
        [self.teamLogoWeb loadHTMLString:dataModel.html_team_logo baseURL:nil];
    } else {
        self.imageView.hidden = NO;
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:dataModel.team_logo]
                          placeholderImage:HT_DEFAULT_IMAGE];
    }
}


- (WKWebView *)teamLogoWeb {
    if (!_teamLogoWeb) {
        _teamLogoWeb = [[WKWebView alloc] init];
        _teamLogoWeb.scrollView.scrollEnabled = NO;
    }
    return _teamLogoWeb;
}

@end
