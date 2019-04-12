//
//  HTHistoryViewController.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2019/4/5.
//  Copyright © 2019 Dean_F. All rights reserved.
//

#import "HTHistoryViewController.h"
#import "HTUserRequest.h"
#import "HTNewsHomeCell.h"

@interface HTHistoryViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray<HTNewsModel *> *dataSource;

@end

@implementation HTHistoryViewController

+ (instancetype)viewController {
    return [[HTHistoryViewController alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"瀏覽歷史";
    [self loadData];
    [self setupTableView];
}

- (void)loadData {
    [self.view showLoadingView];
    [HTUserRequest requestHistoryWithSuccessBlock:^(NSArray<HTNewsModel *> * _Nonnull newsList) {
        self.dataSource = newsList;
        [self.view hideLoadingView];
        [self.tableView reloadData];
        if (newsList.count == 0) {
            [self.view showEmptyView];
        }
    } failBlock:^(BJError *error) {
        [self.view hideLoadingView];
        [self.view showEmptyViewWithTitle:@"獲取數據失敗，點擊重試" tapBlock:^{
            [self.view hideEmptyView];
            [self.view showLoadingView];
            [self loadData];
        }];
    }];
}

- (void)setupTableView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.rowHeight = 90;
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HTNewsHomeCell" bundle:nil]
         forCellReuseIdentifier:@"HTNewsHomeCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HTNewsHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTNewsHomeCell"];
    [cell setupWithNewsModel:self.dataSource[indexPath.row]];
    return cell;
}

@end
