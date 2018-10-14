//
//  HTMatchCompareViewController.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/9.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "HTMatchCompareViewController.h"
#import "HTMatchQuarterCell.h"
#import "HTMatchPtsCompareCell.h"
#import "HTMatchBestPlayerCell.h"

@interface HTMatchCompareViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, weak) HTMatchSummaryModel *summaryModel;

@end

@implementation HTMatchCompareViewController

+ (instancetype)viewController {
    return kLoadStoryboardWithName(@"MatchCompare");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
}

- (void)dealloc {
    NSLog(@"%@ dealloc", NSStringFromClass(self.class));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshWithMatchSummaryModel:(HTMatchSummaryModel *)summaryModel {
    [self.tableView.mj_header endRefreshing];
    self.summaryModel = summaryModel;
    [self.tableView reloadData];
}

- (void)setupViews {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 40;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HTMatchQuarterCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([HTMatchQuarterCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HTMatchPtsCompareCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([HTMatchPtsCompareCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HTMatchBestPlayerCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([HTMatchBestPlayerCell class])];
    
    kWeakSelf
    self.tableView.mj_header = [MJRefreshGenerator bj_headerWithRefreshingBlock:^{
        if (weakSelf.onTableHeaderRefreshBlock) {
            weakSelf.onTableHeaderRefreshBlock();
        }
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        HTMatchQuarterCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HTMatchQuarterCell class])];
        [cell setupWithMatchSummaryModel:self.summaryModel];
        return cell;
    }
    if (indexPath.section == 1) {
        HTMatchPtsCompareCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HTMatchPtsCompareCell class])];
        [cell setupWithMatchSummaryModel:self.summaryModel];
        return cell;
    }
    HTMatchBestPlayerCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HTMatchBestPlayerCell class])];
    [cell setupWithMatchSummaryModel:self.summaryModel];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 105;
    }
    if (indexPath.section == 1) {
        return 320;
    }
    return 260;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section > 0) {
        return 10;
    }
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001;
}

@end
