//
//  HTNoCommentFooterView.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2019/4/14.
//  Copyright © 2019 Dean_F. All rights reserved.
//

#import "HTNoCommentFooterView.h"

@implementation HTNoCommentFooterView

+ (instancetype)skargfooterViewWithFrame:(CGRect)frame {
    HTNoCommentFooterView *footerView = kLoadXibWithName(NSStringFromClass([HTNoCommentFooterView class]));
    footerView.frame = frame;
    return footerView;
}

@end
