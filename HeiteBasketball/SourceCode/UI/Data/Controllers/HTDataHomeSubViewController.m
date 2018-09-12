//
//  HTDataHomeSubViewController.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/11.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "HTDataHomeSubViewController.h"
#import "HTDataHomeRequest.h"
#import "HTDataHomeCell.h"

@interface HTDataHomeSubViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) HTDataHomeInfoModel *homeInfoModel;
@property (nonatomic, strong) BJError *error;

@end

@implementation HTDataHomeSubViewController

+ (instancetype)viewController {
    return kLoadStoryboardWithName(@"DataHomeSub");
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
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HTDataHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTDataHomeCell"];
    switch (indexPath.row) {
            case 0: {
                cell.showMoreBlock = ^{
                    
                };
                [cell setupWithTitle:@"得分" datas:self.homeInfoModel.pts];
            } break;
            
            case 1: {
                cell.showMoreBlock = ^{
                    
                };
                [cell setupWithTitle:@"籃板" datas:self.homeInfoModel.reb];
            } break;
            
            case 2: {
                cell.showMoreBlock = ^{
                    
                };
                [cell setupWithTitle:@"助攻" datas:self.homeInfoModel.ast];
            } break;
            
            case 3: {
                cell.showMoreBlock = ^{
                    
                };
                [cell setupWithTitle:@"搶斷" datas:self.homeInfoModel.stl];
            } break;
            
            case 4: {
                cell.showMoreBlock = ^{
                    
                };
                [cell setupWithTitle:@"蓋帽" datas:self.homeInfoModel.blk];
            } break;
            
            case 5: {
                cell.showMoreBlock = ^{
                    
                };
                [cell setupWithTitle:@"失誤" datas:self.homeInfoModel.turnover];
            } break;
            
        default:
            break;
    }
    return cell;
}

- (void)setupViews {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 160;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HTDataHomeCell" bundle:nil]
         forCellReuseIdentifier:@"HTDataHomeCell"];
    
    kWeakSelf
    self.tableView.mj_header = [MJRefreshGenerator bj_headerWithRefreshingBlock:^{
        [weakSelf loadData];
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
    
    if (self.error) {
        if (!self.homeInfoModel) {
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
    [HTDataHomeRequest requestWithType:self.type successBlock:^(HTDataHomeInfoModel *infoModel) {
        self.homeInfoModel = infoModel;
        [self refreshUI];
    } errorBlock:^(BJError *error) {
        self.error = error;
        [self refreshUI];
    }];
    
}

@end
