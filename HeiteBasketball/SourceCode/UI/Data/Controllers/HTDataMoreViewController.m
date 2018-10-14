//
//  HTDataMoreViewController.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/17.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "HTDataMoreViewController.h"
#import "HTDataHomePlayerCell.h"
#import "HTDataHomeTeamCell.h"

#import "HTDataHomeRequest.h"

@interface HTDataMoreViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *dataList;
@property (nonatomic, strong) BJError *error;

@end

@implementation HTDataMoreViewController

+ (instancetype)viewController {
    return kLoadStoryboardWithName(@"DataMore");
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
    return self.dataList.count / 5 + self.dataList.count % 5 > 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger len = 5;
    if (self.dataList.count < (indexPath.row + 1) * 5) {
        len = self.dataList.count % 5;
    }
    
    if (self.type == 1) {
        HTDataHomePlayerCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HTDataHomePlayerCell class])];
        
        [cell setupWithDatas:[self.dataList subarrayWithRange:NSMakeRange(5 * indexPath.row, len)]];
        return cell;
    }
    HTDataHomeTeamCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HTDataHomeTeamCell class])];
    
    [cell setupWithDatas:[self.dataList subarrayWithRange:NSMakeRange(5 * indexPath.row, len)]];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.type == 1) { // 队员
        return (SCREEN_WIDTH/5-30) * 3 / 2 + 105;
    } else {
        return SCREEN_WIDTH/5 + 48;
    }
}

#pragma mark - private
- (void)setupViews {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    if (self.type == 1) {
        [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HTDataHomePlayerCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([HTDataHomePlayerCell class])];
    } else if (self.type == 2) {
        [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HTDataHomeTeamCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([HTDataHomeTeamCell class])];
    }
    
    [self.view showLoadingView];
}

- (void)refreshUI {
    [self.view hideLoadingView];
    [self.view hideEmptyView];
    [self.tableView.mj_header endRefreshing];
    
    if (self.error) {
        if (!self.dataList) {
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
    [HTDataHomeRequest requestMoreDataWithType:self.type subType:self.subType successBlock:^(NSArray<HTDataHomeModel *> *rankList) {
        self.dataList = rankList;
        [self refreshUI];
    } errorBlock:^(BJError *error) {
        self.error = error;
        [self refreshUI];
    }];
}

@end
