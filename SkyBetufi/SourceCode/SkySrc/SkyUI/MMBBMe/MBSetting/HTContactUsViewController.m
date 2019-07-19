//
//  HTContactUsViewController.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/11/13.
//  Copyright © 2018 Dean_F. All rights reserved.
//

#import "HTContactUsViewController.h"

@interface HTContactUsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansLabel;

@end

@implementation HTContactUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"聯繫我們";
}

- (IBAction)emailTapped:(id)sender {
    kWeakSelf
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"你想要？" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *sendAction = [UIAlertAction actionWithTitle:@"發送郵件" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"mailto:%@", weakSelf.emailLabel.text]];
        [[UIApplication sharedApplication] openURL:url];
    }];
    UIAlertAction *copyAction = [UIAlertAction actionWithTitle:@"拷貝" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIPasteboard *past = [UIPasteboard generalPasteboard];
        past.string = weakSelf.emailLabel.text;
        [weakSelf.view showToast:@"已複製到剪切板！"];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:sendAction];
    [alert addAction:copyAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)fansTapped:(id)sender {
    kWeakSelf
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"你想要？" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *sendAction = [UIAlertAction actionWithTitle:@"打開鏈接" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *url = [NSURL URLWithString:weakSelf.fansLabel.text];
        [[UIApplication sharedApplication] openURL:url];
    }];
    UIAlertAction *copyAction = [UIAlertAction actionWithTitle:@"拷貝" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIPasteboard *past = [UIPasteboard generalPasteboard];
        past.string = weakSelf.fansLabel.text;
        [weakSelf.view showToast:@"已複製到剪切板！"];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:sendAction];
    [alert addAction:copyAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
