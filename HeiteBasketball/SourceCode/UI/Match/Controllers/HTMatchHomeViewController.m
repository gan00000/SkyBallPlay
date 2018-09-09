//
//  HTMatchHomeViewController.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/8.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "HTMatchHomeViewController.h"
#import "HTMatchDetailViewController.h"
#import "HTMatchHomeRequest.h"
#import "HTMatchHomeCell.h"
#import "HTMatchHomeGroupHeaderView.h"

#import "NSDateFormatter+DRExtension.h"
#import "UIView+Loading.h"
#import "UIView+EmptyView.h"

@interface HTMatchHomeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *timeTitleLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *matchList;
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) BOOL requesting;

@end

@implementation HTMatchHomeViewController

+ (instancetype)viewController {
    return kLoadStoryboardWithName(@"MatchHome");
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

- (IBAction)onPreviousButtonTapped:(UIButton *)sender {
    self.startDate = [self.startDate dateBySubtractingDays:8];
    [BJLoadingHud showHUDInView:self.view];
    [self loadData];
}

- (IBAction)onNextButtonTappd:(UIButton *)sender {
    self.startDate = [self.startDate dateByAddingDays:8];
    [BJLoadingHud showHUDInView:self.view];
    [self loadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.matchList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    HTMatchHomeGroupModel *groupModel = self.matchList[section];
    return groupModel.matchList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HTMatchHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTMatchHomeCell"];
    HTMatchHomeGroupModel *groupModel = self.matchList[indexPath.section];
    [cell setupWithMatchModel:groupModel.matchList[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HTMatchHomeGroupModel *groupModel = self.matchList[indexPath.section];
    
    HTMatchDetailViewController *detailVc = [HTMatchDetailViewController viewController];
    detailVc.matchModel = groupModel.matchList[indexPath.row];
    [self.navigationController pushViewController:detailVc animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.matchList.count == 0) {
        return nil;
    }
    HTMatchHomeGroupHeaderView *view = (HTMatchHomeGroupHeaderView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"HTMatchHomeGroupHeaderView"];
    HTMatchHomeGroupModel *groupModel = self.matchList[section];
    view.name = groupModel.groupName;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.matchList.count == 0) {
        return 0.1;
    }
    return 30;
}

#pragma mark - private
- (void)setupViews {
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 130;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HTMatchHomeCell" bundle:nil]
         forCellReuseIdentifier:@"HTMatchHomeCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HTMatchHomeGroupHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"HTMatchHomeGroupHeaderView"];
    
    kWeakSelf
    self.tableView.mj_header = [MJRefreshGenerator bj_headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    // test
    NSDateFormatter *formt = [NSDateFormatter dr_dateFormatter];
    [formt setDateFormat:@"yyyy-MM-dd"];
    self.startDate = [formt dateFromString:@"2018-06-05"];
    
//    self.startDate = [NSDate date];
    [self refreshTimeTitle];
    [self.view showLoadingView];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:10.0
                                                  target:self
                                                selector:@selector(loadData)
                                                userInfo:nil
                                                 repeats:YES];
}

- (void)loadData {
    if (self.requesting) {
        return;
    }
    
    self.requesting = YES;
    
    self.endDate = [self.startDate dateByAddingDays:7];
    
    [HTMatchHomeRequest requestWithStartDate:[self ymdWithDate:self.startDate]
                                     endDate:[self ymdWithDate:self.endDate]
                                successBlock:^(NSArray<HTMatchHomeGroupModel *> *matchList) {
                                    self.matchList = matchList;
                                    [self.tableView reloadData];
                                    
                                    if (matchList.count == 0) {
                                        [self.tableView showEmptyView];
                                    } else {                                        
                                        [self.tableView hideEmptyView];
                                    }
                                    
                                    [self.tableView.mj_header endRefreshing];
                                    [self.view hideLoadingView];
                                    [BJLoadingHud hideHUDInView:self.view];
                                    
                                    [self refreshTimeTitle];
                                    
                                    self.requesting = NO;
                                } errorBlock:^(BJError *error) {
                                    [self.view hideLoadingView];
                                    [self.view showToast:error.msg];
                                    
                                    if (self.matchList.count == 0) {
                                        kWeakSelf
                                        [self.view showEmptyViewWithTitle:@"獲取失敗，點擊重試" tapBlock:^{
                                            [weakSelf loadData];
                                            [weakSelf.tableView hideEmptyView];
                                            [weakSelf.view showLoadingView];
                                        }];
                                    }
                                    
                                    self.requesting = NO;
                                }];
}

- (NSString *)ymdWithDate:(NSDate *)date {
    NSDateFormatter *formt = [NSDateFormatter dr_dateFormatter];
    [formt setDateFormat:@"yyyy-MM-dd"];
    return [formt stringFromDate:date];
}

- (NSString *)mdWithDate:(NSDate *)date {
    NSDateFormatter *formt = [NSDateFormatter dr_dateFormatter];
    [formt setDateFormat:@"MM-dd"];
    return [formt stringFromDate:date];
}

- (void)refreshTimeTitle {
    self.timeTitleLabel.text = [NSString stringWithFormat:@"%@至%@", [self mdWithDate:self.startDate], [self mdWithDate:self.endDate]];
}


@end
