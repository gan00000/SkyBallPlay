//
//  HTMatchSubDsbdViewController.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/10/14.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "HTMatchSubDsbdViewController.h"
#import "HTMatchDataLeftCell.h"
#import "HTMatchDataRightCell.h"

@interface HTMatchSubDsbdViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollContentView;

@property (nonatomic, strong) UITableView *rightTableView;

@property (nonatomic, weak) NSArray<HTMatchDetailsModel *> *dataList;

@end

@implementation HTMatchSubDsbdViewController

+ (instancetype)viewController {
    return kLoadStoryboardWithName(@"MatchSubDsbd");
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self setupLeftTableView];
    [self setupRightTableView];
}

- (void)setupLeftTableView {
    self.leftTableView.delegate = self;
    self.leftTableView.dataSource = self;
    self.leftTableView.rowHeight = 30;
    self.leftTableView.sectionHeaderHeight = 30;
    self.leftTableView.sectionFooterHeight = 30;
    self.leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if (@available(iOS 11.0, *)) {
        self.leftTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.leftTableView registerNib:[UINib nibWithNibName:NSStringFromClass([HTMatchDataLeftCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([HTMatchDataLeftCell class])];
}

- (void)setupRightTableView {
    [self.scrollContentView setContentSize:CGSizeMake(750, self.leftTableView.jx_height)];
    self.rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 750, self.leftTableView.jx_height) style:UITableViewStylePlain];
    self.rightTableView.backgroundColor = [UIColor whiteColor];
    self.rightTableView.delegate = self;
    self.rightTableView.dataSource = self;
    self.rightTableView.rowHeight = 30;
    self.rightTableView.sectionHeaderHeight = 30;
    self.rightTableView.sectionFooterHeight = 30;
    self.rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.rightTableView.bounces = NO;
    self.rightTableView.showsVerticalScrollIndicator = NO;
    self.rightTableView.showsHorizontalScrollIndicator = NO;
    
    if (@available(iOS 11.0, *)) {
        self.rightTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    [self.rightTableView registerNib:[UINib nibWithNibName:NSStringFromClass([HTMatchDataRightCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([HTMatchDataRightCell class])];
    
    [self.scrollContentView addSubview:self.rightTableView];
}

- (void)refreshWithDetailList:(NSArray<HTMatchDetailsModel *> *)detailList {
    self.dataList = detailList;
    
    [self.leftTableView reloadData];
    [self.rightTableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HTMatchDetailsModel *model = self.dataList[indexPath.row];
    if (tableView == self.leftTableView) {
        HTMatchDataLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HTMatchDataLeftCell class])];
        [cell refreshWithName:model.name row:indexPath.row];
        return cell;
    }
    HTMatchDataRightCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HTMatchDataRightCell class])];
    [cell refreshWithModel:model row:indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.jx_width, 30)];
    view.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"f4f7f0"];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 29, tableView.jx_width, 1)];
    line.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"dddddd"];
    [view addSubview:line];
    
    if (tableView == self.leftTableView) {
        UILabel *label = [[UILabel alloc] initWithFrame:view.bounds];
        label.text = @"球員";
        label.textColor = [UIColor hx_colorWithHexRGBAString:@"111111"];
        label.font = [UIFont systemFontOfSize:12];
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
    } else {
        
    }
    
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.jx_width, 30)];
    view.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"f4f7f0"];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.jx_width, 1)];
    line.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"dddddd"];
    [view addSubview:line];
    
    if (tableView == self.rightTableView) {
        
    }
    
    return view;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.leftTableView) {
        self.rightTableView.contentOffset = scrollView.contentOffset;
    } else {
        self.leftTableView.contentOffset = scrollView.contentOffset;
    }
}

@end
