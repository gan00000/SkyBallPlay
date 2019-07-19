//
//  TZPhotoPickerController+DRExtention.m
//  Records
//
//  Created by 冯生伟 on 2018/9/7.
//  Copyright © 2018年 DuoRong Technology Co., Ltd. All rights reserved.
//

#import "TZPhotoPickerController+DRExtention.h"
#import <AVFoundation/AVFoundation.h>

@implementation TZPhotoPickerController (DRExtention)

- (void)takePhoto {
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusAuthorized) {
        [self openCamera];
    } else if (status == AVAuthorizationStatusDenied) {
        [HTUserManager cameraDenied];
    } else {
        kWeakSelf
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (granted) {
                    [weakSelf openCamera];
                }
            });
        }];
    }
}

- (void)openCamera {
    [self performSelector:@selector(pushImagePickerController) withObject:nil afterDelay:NO];
}

@end
