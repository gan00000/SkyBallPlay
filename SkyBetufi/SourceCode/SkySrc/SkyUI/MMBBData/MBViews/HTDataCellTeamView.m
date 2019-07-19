//
//  HTDataCellTeamView.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/14.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "HTDataCellTeamView.h"
#import <WebKit/WebKit.h>

@interface HTDataCellTeamView ()

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *teamNameLabel;

@property (nonatomic, strong) WKWebView *teamLogoWeb;
@property (nonatomic, assign) NSInteger width;


@end

@implementation HTDataCellTeamView

+ (instancetype)dataCellViewWithFrame:(CGRect)frame addToView:(UIView *)view {
    UIView *contentView = [[UIView alloc] initWithFrame:frame];
    HTDataCellTeamView *cellView = kLoadXibWithName(@"HTDataCellTeamView");
    cellView.frame = cellView.bounds;
    cellView.width = ceil(frame.size.width);
    [contentView addSubview:cellView];
    [view addSubview:contentView];
    
    return cellView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self addSubview:self.teamLogoWeb];
    [self.teamLogoWeb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.imageView);
    }];
}

- (void)setupWithDataModel:(HTDataHomeModel *)dataModel {
    self.scoreLabel.text = [NSString stringWithFormat:@"%.1f", dataModel.pts];
    self.teamNameLabel.text = dataModel.teamName;
    
    [dataModel imageUrlFixWithWidth:self.width-30];
    
    self.imageView.hidden = YES;
    self.teamLogoWeb.hidden = YES;
    if (dataModel.html_team_logo.length > 0) {
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
        _teamLogoWeb.clipsToBounds = YES;
    }
    return _teamLogoWeb;
}

@end
