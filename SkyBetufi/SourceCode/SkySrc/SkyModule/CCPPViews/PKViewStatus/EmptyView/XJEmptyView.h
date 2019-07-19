//
//  XJEmptyView.h
//  Exchange
//
//  Created by Marco on 2017/3/7.
//  Copyright © 2017年 zhugelicai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XJEmptyView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (nonatomic, copy) dispatch_block_t contentTapBlock;

@end
