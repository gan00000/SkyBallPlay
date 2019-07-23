//
//  HTUserInfoEditViewController.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2019/4/5.
//  Copyright © 2019 Dean_F. All rights reserved.
//

#import "HTUserInfoEditViewController.h"
#import <Photos/Photos.h>
#import "TZImagePickerController.h"
#import "HTUserRequest.h"
#import "DRSandBoxManager.h"

@interface HTUserInfoEditViewController ()

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet JXImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UIView *tipView;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLeft;
@property (weak, nonatomic) IBOutlet UILabel *emailRight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userNameContentHeight;

@property (nonatomic, copy) NSString *selectedImageBase64;
@property (nonatomic, assign) BOOL avatarChange;
@property (nonatomic, assign) BOOL userNameChange;
@property (nonatomic, assign) BOOL emailChange;

@end

@implementation HTUserInfoEditViewController

+ (instancetype)skargviewController {
    return [[HTUserInfoEditViewController alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"個人信息";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveUserInfo)];
    
    HTUserInfoModel *userInfoModel = [HTUserManager skarg_userInfo];
    self.userNameLabel.text = userInfoModel.display_name;
    self.avatarImageView.image = userInfoModel.avatar;
    self.emailLabel.text = userInfoModel.user_email;
    if (userInfoModel.user_email.length) {
        self.emailLeft.hidden = NO;
        self.emailRight.hidden = NO;
    } else {
        self.emailLeft.hidden = YES;
        self.emailRight.hidden = YES;
    }
    
    if (userInfoModel.change_name) {
        self.tipView.hidden = YES;
        self.userNameTextField.hidden = YES;
        self.userNameContentHeight.constant = 55;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onUserNameChagne) name:UITextFieldTextDidChangeNotification object:self.userNameTextField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onEmailChagne) name:UITextFieldTextDidChangeNotification object:self.emailTextField];
}

#pragma mark - Actions
- (IBAction)avatarSelectAction:(UIButton *)sender {
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusAuthorized) {
        [self showTZImagePickerController];
    } else if (status == PHAuthorizationStatusDenied) {
        [HTUserManager skargphotoAlbumDenied];
    } else {
        kWeakSelf
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status){
            dispatch_async(dispatch_get_main_queue(), ^{
                if (status == PHAuthorizationStatusAuthorized){
                    [weakSelf showTZImagePickerController];
                }
            });
        }];
    }
}

- (void)saveUserInfo {
    [BJLoadingHud showHUDWithText:@"正在保存" inView:self.navigationController.view];
    NSString *email;
    NSString *userName;
    NSString *base64Avatar;
    
    if (self.emailChange) {
        email = self.emailTextField.text;
    }
    if (self.userNameChange) {
        userName = self.userNameTextField.text;
    }
    if (self.avatarChange) {
        base64Avatar = self.selectedImageBase64;
    }
    
    kWeakSelf
    [HTUserRequest skargupdateUserInfoWithEmail:email displayName:userName file:base64Avatar successBlock:^(NSDictionary * _Nonnull userInfo) {
        [HTUserManager skarg_refreshUserInfoWithSuccessBlock:^{
            [BJLoadingHud hideHUDInView:weakSelf.navigationController.view];
            [weakSelf.view showToast:@"保存成功"];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
    } failBlock:^(BJError *error) {
        [BJLoadingHud hideHUDInView:weakSelf.navigationController.view];
        [weakSelf.view showToast:@"保存失敗"];
    }];
}

- (void)onUserNameChagne {
    self.userNameChange = YES;
}

- (void)onEmailChagne {
    self.emailChange = YES;
}

- (BOOL)skarg_shouldForbidSlideBackAction {
    return self.avatarChange || self.userNameChange || self.emailChange;
}

#pragma mark - private
- (void)showTZImagePickerController {
    CGFloat cropHeight = SCREEN_WIDTH;
    kWeakSelf
    TZImagePickerController *imagePickerViewController = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:3 delegate:nil pushPhotoPickerVc:YES];
    imagePickerViewController.isSelectOriginalPhoto = YES;
    imagePickerViewController.allowPickingVideo = NO;
    imagePickerViewController.allowCrop = YES;
    imagePickerViewController.cropRect = CGRectMake(0, (SCREEN_HEIGHT-cropHeight)/2, SCREEN_WIDTH, cropHeight);
    imagePickerViewController.naviTitleColor = [UIColor whiteColor];
    imagePickerViewController.barItemTextColor = [UIColor whiteColor];
    [imagePickerViewController setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        UIImage *image = photos.firstObject;
        NSData *data = UIImageJPEGRepresentation(image, 0.6);
        weakSelf.avatarImageView.image = [UIImage imageWithData:data];
        weakSelf.selectedImageBase64 = [data base64EncodedStringWithOptions:0];
        weakSelf.avatarChange = YES;
        BJLog(@"base64: %@", weakSelf.selectedImageBase64);
    }];
    [imagePickerViewController.navigationBar setupBackground];
    imagePickerViewController.title = @"相冊";
    [self presentViewController:imagePickerViewController animated:YES completion:nil];
}

@end
