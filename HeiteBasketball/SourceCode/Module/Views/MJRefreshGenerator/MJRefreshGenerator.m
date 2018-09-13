//
//  MJRefreshGenerator.m
//  Exchange
//
//  Created by Marco on 2017/2/22.
//  Copyright © 2017年 zhugelicai. All rights reserved.
//

#import "MJRefreshGenerator.h"

@implementation MJRefreshGenerator

+ (MJRefreshStateHeader *)bj_headerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock{
    MJRefreshStateHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:refreshingBlock];
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"释放更新" forState:MJRefreshStatePulling];
    [header setTitle:@"正在更新" forState:MJRefreshStateRefreshing];
    [header setTitle:@"加载完成" forState:MJRefreshStateNoMoreData];
    header.lastUpdatedTimeLabel.hidden = YES;
    return header;
}

+ (MJRefreshBackStateFooter *)bj_foorterWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock {
    MJRefreshBackStateFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:refreshingBlock];
    [footer setTitle:@"上拉加载更多" forState:MJRefreshStateIdle];
    [footer setTitle:@"释放加载" forState:MJRefreshStatePulling];
    [footer setTitle:@"正在加载" forState:MJRefreshStateRefreshing];
    [footer setTitle:@"暂无更多数据" forState:MJRefreshStateNoMoreData];
    return footer;
}

@end
