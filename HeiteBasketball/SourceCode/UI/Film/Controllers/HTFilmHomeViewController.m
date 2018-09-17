//
//  HTFilmHomeViewController.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/8.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "HTFilmHomeViewController.h"
#import "HTNewsDetailViewController.h"
#import "HTFilmHomeRequest.h"
#import "HTFilmHomeCell.h"
#import "HTNewsHomeCell.h"

@interface HTFilmHomeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) HTFilmHomeRequest *request;
@property (nonatomic, strong) NSArray *filmList;
@property (nonatomic, strong) BJError *error;

@end

@implementation HTFilmHomeViewController

+ (instancetype)viewController {
    return kLoadStoryboardWithName(@"FilmHome");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filmList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HTNewsModel *model = self.filmList[indexPath.row];
    if ([model.news_type isEqualToString:@"新聞"]) {
        HTNewsHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTNewsHomeCell"];
        [cell setupWithNewsModel:model];
        return cell;
    }
    
    HTFilmHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTFilmHomeCell"];
    [cell setupWithNewsModel:self.filmList[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HTNewsModel *model = self.filmList[indexPath.row];
    if ([model.news_type isEqualToString:@"新聞"]) {
        return 90;
    }
    return model.filmCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HTNewsModel *newsModel = self.filmList[indexPath.row];
    
    HTNewsDetailViewController *detailVc = [HTNewsDetailViewController viewController];
    detailVc.newsModel = newsModel;
    [self.navigationController pushViewController:detailVc animated:YES];
}

#pragma mark - private
- (void)setupViews {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HTFilmHomeCell" bundle:nil]
         forCellReuseIdentifier:@"HTFilmHomeCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HTNewsHomeCell" bundle:nil]
         forCellReuseIdentifier:@"HTNewsHomeCell"];
    
    kWeakSelf
    self.tableView.mj_header = [MJRefreshGenerator bj_headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    
    self.tableView.mj_footer = [MJRefreshGenerator bj_foorterWithRefreshingBlock:^{
        [weakSelf loadNextPage];
    }];
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.error = nil;
    
    [self.view showLoadingView];
}

- (void)refreshUI {
    [self.view hideLoadingView];
    [self.view hideEmptyView];
    
    [self.tableView.mj_header endRefreshing];
    if (self.request.hasMore) {
        [self.tableView.mj_footer endRefreshing];
    } else {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
    
    if (self.error) {
        if (!self.filmList) {
            kWeakSelf
            [self.view showEmptyViewWithTitle:@"獲取失敗，點擊重試" tapBlock:^{
                [weakSelf.view hideEmptyView];
                [weakSelf.view showLoadingView];
                [weakSelf loadData];
            }];
        } else {
            [self.view showToast:self.error.msg];
        }
        self.error = nil;
    }
    [self.tableView reloadData];
}

- (void)loadData {
    kWeakSelf
    [self.request requestWithSuccessBlock:^(NSArray<HTNewsModel *> *newsList) {
        weakSelf.filmList = newsList;
        [weakSelf refreshUI];
    } errorBlock:^(BJError *error) {
        weakSelf.error = error;
        [weakSelf refreshUI];
    }];
}

- (void)loadNextPage {
    kWeakSelf
    [self.request loadNextPageWithSuccessBlock:^(NSArray<HTNewsModel *> *newsList) {
        weakSelf.filmList = newsList;
        [weakSelf refreshUI];
    } errorBlock:^(BJError *error) {
        [weakSelf refreshUI];
    }];
}

#pragma mark - lazy load
- (HTFilmHomeRequest *)request {
    if (!_request) {
        _request = [[HTFilmHomeRequest alloc] init];
    }
    return _request;
}


@end
