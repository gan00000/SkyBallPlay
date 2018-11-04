//
//  HTNewsHomeCell.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/9.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "HTNewsHomeCell.h"
#import <UShareUI/UShareUI.h>
#import "BJViewControllerCenter.h"

@interface HTNewsHomeCell ()

@property (weak, nonatomic) IBOutlet UIImageView *thumbImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *viewLabel;
@property (weak, nonatomic) IBOutlet UIView *shareButtonContentView;

@property (nonatomic, weak) HTNewsModel *newsModel;

@end

@implementation HTNewsHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if ([self isCanShare]) {
        self.shareButtonContentView.hidden = NO;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupWithNewsModel:(HTNewsModel *)newsModel {
    self.newsModel = newsModel;
    [self.thumbImageView sd_setImageWithURL:[NSURL URLWithString:newsModel.img_url] placeholderImage:HT_DEFAULT_IMAGE];
    self.titleLabel.text = newsModel.title;
    self.timeLabel.text = newsModel.time;
    self.viewLabel.text = newsModel.view_count;
}

- (IBAction)onShareButtonTapped:(id)sender {
    kWeakSelf
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        //创建网页内容对象
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:weakSelf.newsModel.title descr:nil thumImage:weakSelf.newsModel.img_url];
        //设置网页地址
        shareObject.webpageUrl = weakSelf.newsModel.url;
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:[BJViewControllerCenter currentViewController] completion:^(id result, NSError *error) {
            NSLog(@"result = %@", result);
        }];
    }];
}

- (BOOL)isCanShare {
    return ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_Facebook] && [[UMSocialManager defaultManager] isSupport:UMSocialPlatformType_Facebook]) ||
    ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_Line] && [[UMSocialManager defaultManager] isSupport:UMSocialPlatformType_Line]);
}

@end
