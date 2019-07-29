//
//  BJBaseResponceModel.m
//  BenjiaPro
//
//  Created by 吕磊 on 2017/5/26.
//  Copyright © 2017年 Benjia. All rights reserved.
//
#import "BJBaseResponceModel.h"

@implementation BJBaseResponceModel

- (NSInteger)skargpagesValueOfPage {
    if (self.page) {
        return [self.page[@"pages"] integerValue];
    }
    return 0;
}

- (NSInteger)skargtotalValueOfPage {
//    if (self.page) {
//        return [self.page[@"total"] integerValue];
//    }
//    return 0;
    return self.total;
}

@end
