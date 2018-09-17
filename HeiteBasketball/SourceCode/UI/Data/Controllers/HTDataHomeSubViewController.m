//
//  HTDataHomeSubViewController.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/11.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "HTDataHomeSubViewController.h"
#import "HTDataMoreViewController.h"
#import "HTDataHomeRequest.h"
#import "HTDataHomePlayerCell.h"
#import "HTDataHomeTeamCell.h"

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
    
    HTDataHomePlayerCell *playerCell;
    HTDataHomeTeamCell *teamCell;
    if (self.type == 1) {
        playerCell = [tableView dequeueReusableCellWithIdentifier:@"HTDataHomePlayerCell"];
    } else {
        teamCell = [tableView dequeueReusableCellWithIdentifier:@"HTDataHomeTeamCell"];
    }
    // TODO: 查看更多，点击回调
    kWeakSelf
    switch (indexPath.row) {
            case 0: {
                if (self.type == 1) {
                    playerCell.showMoreBlock = ^{
                        HTDataMoreViewController *moreVc = [HTDataMoreViewController viewController];
                        [weakSelf.navigationController pushViewController:moreVc animated:YES];
                    };
                    [playerCell setupWithTitle:@"得分" datas:self.homeInfoModel.pts];
                } else {
                    teamCell.showMoreBlock = ^{
                        HTDataMoreViewController *moreVc = [HTDataMoreViewController viewController];
                        [weakSelf.navigationController pushViewController:moreVc animated:YES];
                    };
                    [teamCell setupWithTitle:@"得分" datas:self.homeInfoModel.pts];
                }
            } break;
            
            case 1: {
                if (self.type == 1) {
                    playerCell.showMoreBlock = ^{
                        HTDataMoreViewController *moreVc = [HTDataMoreViewController viewController];
                        [weakSelf.navigationController pushViewController:moreVc animated:YES];
                    };
                    [playerCell setupWithTitle:@"得分" datas:self.homeInfoModel.reb];
                } else {
                    teamCell.showMoreBlock = ^{
                        HTDataMoreViewController *moreVc = [HTDataMoreViewController viewController];
                        [weakSelf.navigationController pushViewController:moreVc animated:YES];
                    };
                    [teamCell setupWithTitle:@"得分" datas:self.homeInfoModel.reb];
                }
            } break;
            
            case 2: {
                if (self.type == 1) {
                    playerCell.showMoreBlock = ^{
                        HTDataMoreViewController *moreVc = [HTDataMoreViewController viewController];
                        [weakSelf.navigationController pushViewController:moreVc animated:YES];
                    };
                    [playerCell setupWithTitle:@"得分" datas:self.homeInfoModel.ast];
                } else {
                    teamCell.showMoreBlock = ^{
                        HTDataMoreViewController *moreVc = [HTDataMoreViewController viewController];
                        [weakSelf.navigationController pushViewController:moreVc animated:YES];
                    };
                    [teamCell setupWithTitle:@"得分" datas:self.homeInfoModel.ast];
                }
            } break;
            
            case 3: {
                if (self.type == 1) {
                    playerCell.showMoreBlock = ^{
                        HTDataMoreViewController *moreVc = [HTDataMoreViewController viewController];
                        [weakSelf.navigationController pushViewController:moreVc animated:YES];
                    };
                    [playerCell setupWithTitle:@"得分" datas:self.homeInfoModel.stl];
                } else {
                    teamCell.showMoreBlock = ^{
                        HTDataMoreViewController *moreVc = [HTDataMoreViewController viewController];
                        [weakSelf.navigationController pushViewController:moreVc animated:YES];
                    };
                    [teamCell setupWithTitle:@"得分" datas:self.homeInfoModel.stl];
                }
            } break;
            
            case 4: {
                if (self.type == 1) {
                    playerCell.showMoreBlock = ^{
                        HTDataMoreViewController *moreVc = [HTDataMoreViewController viewController];
                        [weakSelf.navigationController pushViewController:moreVc animated:YES];
                    };
                    [playerCell setupWithTitle:@"得分" datas:self.homeInfoModel.blk];
                } else {
                    teamCell.showMoreBlock = ^{
                        HTDataMoreViewController *moreVc = [HTDataMoreViewController viewController];
                        [weakSelf.navigationController pushViewController:moreVc animated:YES];
                    };
                    [teamCell setupWithTitle:@"得分" datas:self.homeInfoModel.blk];
                }
            } break;
            
            case 5: {
                if (self.type == 1) {
                    playerCell.showMoreBlock = ^{
                        HTDataMoreViewController *moreVc = [HTDataMoreViewController viewController];
                        [weakSelf.navigationController pushViewController:moreVc animated:YES];
                    };
                    [playerCell setupWithTitle:@"得分" datas:self.homeInfoModel.turnover];
                } else {
                    teamCell.showMoreBlock = ^{
                        HTDataMoreViewController *moreVc = [HTDataMoreViewController viewController];
                        [weakSelf.navigationController pushViewController:moreVc animated:YES];
                    };
                    [teamCell setupWithTitle:@"得分" datas:self.homeInfoModel.turnover];
                }
            } break;
            
        default:
            break;
    }
    if (self.type == 1) {
        return playerCell;
    } else {
        return teamCell;
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger count = 0;
    switch (indexPath.row) {
        case 0: {
            count = self.homeInfoModel.pts.count;
        } break;
            
        case 1: {
            count = self.homeInfoModel.reb.count;
        } break;
            
        case 2: {
            count = self.homeInfoModel.ast.count;
        } break;
            
        case 3: {
            count = self.homeInfoModel.stl.count;
        } break;
            
        case 4: {
            count = self.homeInfoModel.blk.count;
        } break;
            
        case 5: {
            count = self.homeInfoModel.turnover.count;
        } break;
            
        default:
            break;
    }
    if (count) {
        if (self.type == 1) { // 队员
            return (SCREEN_WIDTH/count-30) * 3 / 2 + 145;
        } else {
            return SCREEN_WIDTH / count + 88;
        }
    }
    return 0.000001;
}

#pragma mark - private
- (void)setupViews {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if (self.type == 1) {
        [self.tableView registerNib:[UINib nibWithNibName:@"HTDataHomePlayerCell" bundle:nil]
             forCellReuseIdentifier:@"HTDataHomePlayerCell"];
    } else {
        [self.tableView registerNib:[UINib nibWithNibName:@"HTDataHomeTeamCell" bundle:nil]
             forCellReuseIdentifier:@"HTDataHomeTeamCell"];
    }
    
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
