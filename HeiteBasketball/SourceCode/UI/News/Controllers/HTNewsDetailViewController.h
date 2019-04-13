//
//  HTNewsDetailViewController.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/10.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "BJBaseViewController.h"
#import "HTNewsModel.h"

@interface HTNewsDetailViewController : BJBaseViewController

@property (nonatomic, weak) HTNewsModel *newsModel;
@property (nonatomic, copy) NSString *post_id;

@end
