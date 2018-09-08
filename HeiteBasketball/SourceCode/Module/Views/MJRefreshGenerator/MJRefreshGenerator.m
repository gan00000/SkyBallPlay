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
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:refreshingBlock];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.labelLeftInset = -20;
    [header setTitle:@"         下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"         释放更新" forState:MJRefreshStatePulling];
    [header setTitle:@"         正在更新" forState:MJRefreshStateRefreshing];
    [header setTitle:@"         释放更新" forState:MJRefreshStateWillRefresh];
    [header setTitle:@"" forState:MJRefreshStateNoMoreData];
    
    NSArray *images = @[[UIImage imageNamed:@"refresh_image_1"],
                        [UIImage imageNamed:@"refresh_image_2"],
                        [UIImage imageNamed:@"refresh_image_3"],
                        [UIImage imageNamed:@"refresh_image_4"],
                        [UIImage imageNamed:@"refresh_image_5"],
                        [UIImage imageNamed:@"refresh_image_6"]];
    [header setImages:[images subarrayWithRange:NSMakeRange(0, 1)] forState:MJRefreshStateIdle];
    [header setImages:images duration:0.5 forState:MJRefreshStateRefreshing];
    return header;
}
+ (MJRefreshAutoStateFooter *)bj_foorterWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock {
    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:refreshingBlock];
    [footer setTitle:@"上拉加载更多" forState:MJRefreshStateIdle];
    [footer setTitle:@"释放加载" forState:MJRefreshStatePulling];
    [footer setTitle:@"正在加载" forState:MJRefreshStateRefreshing];
    [footer setTitle:@"释放加载" forState:MJRefreshStateWillRefresh];
    [footer setTitle:@"暂无更多数据" forState:MJRefreshStateNoMoreData];
    
    NSArray *images = @[[UIImage imageNamed:@"refresh_image_1"],
                        [UIImage imageNamed:@"refresh_image_2"],
                        [UIImage imageNamed:@"refresh_image_3"],
                        [UIImage imageNamed:@"refresh_image_4"],
                        [UIImage imageNamed:@"refresh_image_5"],
                        [UIImage imageNamed:@"refresh_image_6"]];
    [footer setImages:[images subarrayWithRange:NSMakeRange(0, 1)] forState:MJRefreshStateIdle];
    [footer setImages:images duration:0.5 forState:MJRefreshStateRefreshing];
    return footer;
}

@end
