//
//  HTRankHomeCell.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/13.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "HTRankHomeCell.h"
#import "HTRankLeftCell.h"
#import "HTRankRightCell.h"

@interface HTRankHomeCell () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollContentView;

@property (nonatomic, strong) UITableView *rightTableView;
@property (nonatomic, weak) NSArray<HTRankModel *> *rankList;
@property (nonatomic, assign) BOOL firstLoad;

@end

@implementation HTRankHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.firstLoad = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.firstLoad) {
        self.firstLoad = NO;
        [self setupLeftTableView];
        [self setupRightTableView];
    }
}

- (void)setupWithTitle:(NSString *)title rankList:(NSArray<HTRankModel *> *)rankList {
    self.titleLabel.text = title;
    
    self.rankList = rankList;
    [self.leftTableView reloadData];
    [self.rightTableView reloadData];
    
    self.rightTableView.jx_height = (rankList.count + 1) * 30;
}

- (void)setupLeftTableView {
    self.leftTableView.delegate = self;
    self.leftTableView.dataSource = self;
    self.leftTableView.rowHeight = 30;
    self.leftTableView.sectionHeaderHeight = 30;
    self.leftTableView.sectionFooterHeight = 0;
    self.leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if (@available(iOS 11.0, *)) {
        self.leftTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    [self.leftTableView registerNib:[UINib nibWithNibName:NSStringFromClass([HTRankLeftCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([HTRankLeftCell class])];
}

- (void)setupRightTableView {
    [self.scrollContentView setContentSize:CGSizeMake(560, self.leftTableView.jx_height)];
    self.rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 560, self.leftTableView.jx_height) style:UITableViewStylePlain];
    self.rightTableView.backgroundColor = [UIColor whiteColor];
    self.rightTableView.delegate = self;
    self.rightTableView.dataSource = self;
    self.rightTableView.rowHeight = 30;
    self.rightTableView.sectionHeaderHeight = 30;
    self.rightTableView.sectionFooterHeight = 0;
    self.rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.rightTableView.bounces = NO;
    self.rightTableView.showsVerticalScrollIndicator = NO;
    self.rightTableView.showsHorizontalScrollIndicator = NO;
    
    if (@available(iOS 11.0, *)) {
        self.rightTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    [self.rightTableView registerNib:[UINib nibWithNibName:NSStringFromClass([HTRankRightCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([HTRankRightCell class])];
    
    [self.scrollContentView addSubview:self.rightTableView];
}

- (void)addLabelToView:(UIView *)view withFrame:(CGRect)frame text:(NSString *)text {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.textColor = [UIColor hx_colorWithHexRGBAString:@"111111"];
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.rankList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HTRankModel *model = self.rankList[indexPath.row];
    if (tableView == self.leftTableView) {
        HTRankLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HTRankLeftCell class])];
        [cell refreshWithRankModel:model row:indexPath.row];
        return cell;
    }
    HTRankRightCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HTRankRightCell class])];
    [cell refreshWithRankModel:model row:indexPath.row];
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
        [self addLabelToView:view withFrame:CGRectMake(0, 0, 50, 30) text:@"排名"];
        [self addLabelToView:view withFrame:CGRectMake(50, 0, 100, 30) text:@"隊名"];
    } else {
        NSArray *titles = @[@"勝", @"負", @"勝率", @"主場",
                            @"客場", @"賽區", @"得分", @"失分"];
        for (NSInteger i=0; i<8; i++) {
            [self addLabelToView:view withFrame:CGRectMake(i*70, 0, 70, 30) text:titles[i]];
        }
    }
    
    return view;
}

@end
