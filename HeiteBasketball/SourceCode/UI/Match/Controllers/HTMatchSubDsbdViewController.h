//
//  HTMatchSubDsbdViewController.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/10/14.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "BJBaseViewController.h"
#import "HTMatchDetailsModel.h"

@interface HTMatchSubDsbdViewController : BJBaseViewController

- (void)refreshWithDetailList:(NSArray<HTMatchDetailsModel *> *)detailList;

@end
