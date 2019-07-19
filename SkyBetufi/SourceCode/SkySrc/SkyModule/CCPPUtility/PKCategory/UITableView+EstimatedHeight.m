//
//  UITableView+EstimatedHeight.m
//  BenjiaPro
//
//  Created by Marco on 2017/10/31.
//  Copyright © 2017年 Benjia. All rights reserved.
//

#import "UITableView+EstimatedHeight.h"

@implementation UITableView (EstimatedHeight)

- (void)disableEstimatedHeight {
    self.estimatedSectionFooterHeight = 0;
    self.estimatedSectionHeaderHeight = 0;
    self.estimatedRowHeight = 0;
}

@end
