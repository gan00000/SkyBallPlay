//
//  HTMatchDashboardViewController.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/9.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "BJBaseViewController.h"
#import "HTMatchCompareModel.h"

@interface HTMatchDashboardViewController : BJBaseViewController

- (void)refreshWithMatchCompareModel:(HTMatchCompareModel *)compareModel;

@end
