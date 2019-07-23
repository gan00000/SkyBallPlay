//
//  HTNewsDetailViewController.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/10.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "HTNewsDetailViewController.h"
#import "HTNewsTopRequest.h"
#import "HTNewsHeaderCell.h"
#import "HTNewsWebCell.h"
#import "HTNewsHomeCell.h"
#import "HTNewsTopHeaderView.h"
#import "PPXXBJNavigationController.h"
#import "HTNewsAdditionRequest.h"
#import "HTUserRequest.h"
#import <BlocksKit/BlocksKit.h>
#import <YYText/YYText.h>
#import "HTCommentGetter.h"
#import "HTNewsCommentCell.h"
#import "HTNoCommentFooterView.h"

@interface HTNewsDetailViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet JXTextView *commentInputView;
@property (weak, nonatomic) IBOutlet UILabel *commentCountLabel;
@property (weak, nonatomic) IBOutlet JXView *commentCountContent;
@property (weak, nonatomic) IBOutlet UIView *buttonContentView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *comtentHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentRight;

@property (nonatomic, strong) HTNewsModel *newsModel;
@property (nonatomic, strong) NSArray *topNewsList;
@property (nonatomic, copy) NSString *htmlContent;
@property (nonatomic, assign) CGFloat newsContentHeight;
@property (nonatomic, assign) BOOL topRequestDone;
@property (nonatomic, assign) BOOL htmlLoadDone;
@property (nonatomic, weak) HTCommentModel *currentCommentModel;
@property (nonatomic, strong) HTCommentGetter *commentGetter;
@property (nonatomic, strong) HTNoCommentFooterView *noCommentsFooterView;

@property (nonatomic, assign) BOOL isFirstShow;

@end

@implementation HTNewsDetailViewController

+ (instancetype)skargviewController {
    return kLoadStoryboardWithName(@"NewsDetail");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
    
    self.isFirstShow = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (self.isFirstShow) {
        self.isFirstShow = NO;
        
        if ([self.commentInputView.text isEqualToString:@" "]) {
            self.commentInputView.text = nil;
        }
        
        [self loadDetailWithCompleteBlock:^{
            [self initDataRequests];
        }];
        [self addHistoryRecord];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (!self.topRequestDone || !self.htmlLoadDone) {
        return 0;
    }
    NSInteger num = 3;
    if (self.commentGetter.hotComments.count > 0) {
        num ++;
    }
    if (self.commentGetter.normalComments.count > 0) {
        num ++;
    }
    return num;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 || section == 1) {
        return 1;
    }
    if (section == 2) {
        return self.topNewsList.count;
    }
    if (section == 3 && self.commentGetter.hotComments.count > 0) {
        return self.commentGetter.hotComments.count;
    } else {
        return self.commentGetter.normalComments.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    kWeakSelf
    if (indexPath.section == 0) {
        HTNewsHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTNewsHeaderCell"];
        [cell setupWithNewsModel:self.newsModel];
        return cell;
    } else if (indexPath.section == 1) {
        HTNewsWebCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTNewsWebCell"];
        if (self.newsContentHeight == 0) {
            [cell setupWithClearHtmlContent:self.htmlContent];
            cell.onContentHeightUpdateBlock = ^(CGFloat height) {
                if (fabs(height - weakSelf.newsContentHeight) < 1) {
                    return;
                }
                weakSelf.newsContentHeight = height;
                [weakSelf.tableView reloadData];
            };
        }
        return cell;
    } else if (indexPath.section == 2) {
        HTNewsHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTNewsHomeCell"];
        [cell setupWithNewsModel:self.topNewsList[indexPath.row]];
        return cell;
    }
    HTNewsCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HTNewsCommentCell class])];
    cell.onReplyBlock = ^(HTCommentModel * _Nonnull commentModel) {
        weakSelf.currentCommentModel = commentModel;
        weakSelf.commentInputView.placeholder = [NSString stringWithFormat:@"回復 %@", commentModel.comment_author];
        weakSelf.commentInputView.text = nil;
        [weakSelf.commentInputView becomeFirstResponder];
    };
    cell.onExpendBlock = ^{
        [weakSelf.tableView beginUpdates];
        [weakSelf.tableView endUpdates];
    };
    if (indexPath.section == 3 && self.commentGetter.hotComments.count > 0) {
        [cell refreshWithCommentModel:self.commentGetter.hotComments[indexPath.row]];
    } else {
        [cell refreshWithCommentModel:self.commentGetter.normalComments[indexPath.row]];
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        HTNewsModel *newsModel = self.topNewsList[indexPath.row];
        
        HTNewsDetailViewController *detailVc = [HTNewsDetailViewController skargviewController];
        detailVc.post_id = newsModel.news_id;
        [self.navigationController pushViewController:detailVc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return self.newsModel.detailHeaderHeight;
    } else if (indexPath.section == 1) {
        return self.newsContentHeight;
    } else if (indexPath.section == 2) {
        return 90;
    }
    HTCommentModel *commentModel;
    if (indexPath.section == 3 && self.commentGetter.hotComments.count > 0) {
        commentModel = self.commentGetter.hotComments[indexPath.row];
    } else {
        commentModel = self.commentGetter.normalComments[indexPath.row];
    }
    return commentModel.cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0 || section == 1) {
        return 0.1;
    }
    return 40;
}

- (UITableViewHeaderFooterView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0 || section == 1) {
        return nil;
    }
    HTNewsTopHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"HTNewsTopHeaderView"];
    if (section == 2) {
        [headerView refreshWithTitle:@"推薦閱讀"];
    } else if (section == 3 && self.commentGetter.hotComments.count > 0) {
        [headerView refreshWithTitle:@"熱門回復"];
    } else {
        [headerView refreshWithTitle:@"全部回復"];
    }
    return headerView;
}

#pragma mark - requests
- (void)loadDetailWithCompleteBlock:(dispatch_block_t)block {
    [HTNewsAdditionRequest requestDetailWithPostId:self.post_id successBlock:^(HTNewsModel * _Nonnull newsModel) {
        self.newsModel = newsModel;
        if (block) {
            block();
        }
    } errorBlock:^(BJError *error) {
        [self.view showToast:@"數據拉取失敗"];
        if (!self.newsModel) {
            [self.view showEmptyViewWithTitle:@"數據拉取失敗，點擊重試" tapBlock:^{
                [self.view hideEmptyView];
                [self.view showLoadingView];
                [self loadDetailWithCompleteBlock:block];
            }];
        }
    }];
}

// 请求html数据、推荐数据、第一页评论
- (void)initDataRequests {
    kWeakSelf
    self.topRequestDone = NO;
    self.htmlLoadDone = YES;
    
    [HTNewsTopRequest requestWithSuccessBlock:^(NSArray<HTNewsModel *> *newsList) {
        weakSelf.topNewsList = newsList;
        weakSelf.topRequestDone = YES;
        [weakSelf refreshUI];
    } errorBlock:^(BJError *error) {
        [weakSelf.view showToast:@"「推薦閱讀」獲取失敗"];
        weakSelf.topRequestDone = YES;
        [weakSelf refreshUI];
    }];
    
    if (!weakSelf.htmlContent) {
        self.htmlLoadDone = NO;
        [self.newsModel getClearContentWithBlock:^(BOOL success, NSString *content) {
            weakSelf.htmlContent = content;
            weakSelf.htmlLoadDone = YES;
            [weakSelf refreshUI];
        }];
    }
    
    [self loadComments];
}

// 加载评论列表
- (void)loadComments {
    if (self.newsModel.total_comment == 0) {
        self.tableView.tableFooterView = self.noCommentsFooterView;
        self.tableView.mj_footer.hidden = YES;
        [self.tableView reloadData];
        return;
    }
    self.tableView.tableFooterView = nil;
    self.tableView.mj_footer.hidden = NO;
    
    kWeakSelf
    [self.commentGetter doRequestWithCompleteBlock:^{
        if (weakSelf.commentGetter.hasMore) {
            [weakSelf.tableView.mj_footer endRefreshing];
        } else {
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        [weakSelf.tableView reloadData];
    }];
}

// 评论后更新页面、获取newsModel，commentsList
- (void)updateAfterComment {
    [self loadDetailWithCompleteBlock:^{
        [self refreshUI];
        [self.commentGetter reset];
        [self loadComments];
    }];
}

- (void)addHistoryRecord {
    [HTUserRequest skargaddHistoryWithNewsId:self.post_id successBlock:^{
        BJLog(@"添加瀏覽歷史成功");
    } failBlock:^(BJError *error) {
        BJLog(@"添加瀏覽歷史失敗");
    }];
}

#pragma mark - UI refresh
- (void)setupViews {
    [self.view showLoadingView];
    
    self.title = @"新聞詳情";
    self.newsContentHeight = 0;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HTNewsHeaderCell" bundle:nil]
         forCellReuseIdentifier:@"HTNewsHeaderCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HTNewsWebCell" bundle:nil]
         forCellReuseIdentifier:@"HTNewsWebCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HTNewsHomeCell" bundle:nil]
         forCellReuseIdentifier:@"HTNewsHomeCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HTNewsTopHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"HTNewsTopHeaderView"];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HTNewsCommentCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([HTNewsCommentCell class])];
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    kWeakSelf
    self.tableView.mj_footer = [MJRefreshGenerator bj_foorterWithRefreshingBlock:^{
        [weakSelf loadComments];
    }];
    
    if ([HTNewsModel canShare]) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_icon_share"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] style:UIBarButtonItemStylePlain target:self action:@selector(onShareButtonTapped:)];
    }
    
    UIImage *commentIcon = [[UIImage imageNamed:@"icon_add_comment"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.commentButton setImage:commentIcon forState:UIControlStateNormal];
    [self.commentButton setTintColor:[UIColor hx_colorWithHexRGBAString:@"999999"]];
    UIImage *saveIcon = [[PPXXBJBaseViewController skargfixImageSize:[UIImage imageNamed:@"icon_add_collection"] toSize:CGSizeMake(20, 20)] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.saveButton setImage:saveIcon forState:UIControlStateNormal];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onInputBegin) name:UITextViewTextDidBeginEditingNotification object:self.commentInputView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onInputEnd) name:UITextViewTextDidEndEditingNotification object:self.commentInputView];
    
    [self.commentInputView bk_addObserverForKeyPath:@"contentSize" task:^(id target) {
        CGFloat height = weakSelf.commentInputView.contentSize.height;
        if (height < 34) {
            height = 34;
        }
        if (height > 92) {
            height = 92;
        }
        if (height != weakSelf.comtentHeight.constant) {
            [UIView animateWithDuration:0.15 animations:^{
                weakSelf.comtentHeight.constant = height;
                [weakSelf.view layoutIfNeeded];
            }];
        }
    }];
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:@" "];
    attr.yy_lineSpacing = 5;
    attr.yy_font = [UIFont systemFontOfSize:15];
    attr.yy_color = [UIColor hx_colorWithHexRGBAString:@"333333"];
    self.commentInputView.attributedText = attr;
}

- (void)refreshUI {
    if (!self.topRequestDone || !self.htmlLoadDone) {
        return;
    }
    
    [self.view hideLoadingView];
    [self.tableView reloadData];
    
    [self setupSaveButton];
    
    if (self.newsModel.total_comment > 0) {
        self.commentCountContent.hidden = NO;
        self.commentCountLabel.text = [NSString stringWithFormat:@"%ld", self.newsModel.total_comment];
    } else {
        self.commentCountContent.hidden = YES;
    }
}

- (void)setupSaveButton {
    if (self.newsModel.my_save) {
        [self.saveButton setTintColor:[UIColor hx_colorWithHexRGBAString:@"fc562e"]];
        self.saveButton.selected = YES;
    } else {
        self.saveButton.selected = NO;
        [self.saveButton setTintColor:[UIColor hx_colorWithHexRGBAString:@"999999"]];
    }
}

#pragma mark - actions
- (void)onShareButtonTapped:(id)sender {
    [self.newsModel share];
}

- (IBAction)onSaveAction:(UIButton *)sender {
    if (![HTUserManager skarg_isUserLogin]) {
        [HTUserManager skarg_doUserLogin];
        [self.view showToast:@"請登錄"];
        return;
    }
    if (sender.selected) {
        [HTUserRequest skargdeleteCollectionWithNewsId:self.newsModel.news_id successBlock:^{
            [self.view showToast:@"已取消收藏"];
            self.newsModel.my_save = NO;
            [self setupSaveButton];
        } failBlock:^(BJError *error) {
            [self.view showToast:@"取消收藏失敗"];
        }];
    } else {
        [HTUserRequest skargaddCollectionWithNewsId:self.newsModel.news_id successBlock:^{
            [self.view showToast:@"已收藏"];
            self.newsModel.my_save = YES;
            [self setupSaveButton];
        } failBlock:^(BJError *error) {
            [self.view showToast:@"收藏失敗"];
        }];
    }
    sender.selected = !sender.selected;
    self.newsModel.my_save = sender.selected;
}

- (IBAction)onShowCommentListAction:(id)sender {
    CGFloat contentHeight = self.newsContentHeight + self.newsModel.detailHeaderHeight + 90*self.topNewsList.count + 40;
    CGFloat commnetHeight = self.tableView.contentSize.height - contentHeight;
    if (commnetHeight > self.tableView.height) {
        [self.tableView setContentOffset:CGPointMake(0, contentHeight) animated:YES];
    } else {
        [self.tableView setContentOffset:CGPointMake(0, contentHeight-(self.tableView.height-commnetHeight)) animated:YES];
    }
}

- (IBAction)sendCommentAction:(id)sender {
    if (self.commentInputView.text.length == 0) {
        [kWindow showToast:@"請輸入評論"];
        return;
    }
    
    [HTUserRequest skargpostCommentWithComment_txt:self.commentInputView.text post_id:self.newsModel.news_id reply_comment_id:self.currentCommentModel.comment_id successBlock:^{
        self.commentInputView.text = nil;
        [self.view endEditing:YES];
        [kWindow showToast:@"評論成功"];
        [self updateAfterComment];
    } failBlock:^(BJError *error) {
        [kWindow showToast:@"評論失敗"];
    }];
}

- (void)onInputBegin {
    if (![HTUserManager skarg_isUserLogin]) {
        [self.view endEditing:YES];
        [HTUserManager skarg_doUserLogin];
        [self.view showToast:@"請登錄"];
        return;
    }
    self.buttonContentView.hidden = YES;
    self.sendButton.hidden = NO;
    [UIView animateWithDuration:0.25 animations:^{
        self.contentRight.constant = 20;
        [self.commentInputView.superview layoutIfNeeded];
    }];
}

- (void)onInputEnd {
    if (self.commentInputView.text.length == 0) {
        self.buttonContentView.hidden = NO;
        self.sendButton.hidden = YES;
        [UIView animateWithDuration:0.25 animations:^{
            self.contentRight.constant = 80;
            [self.commentInputView.superview layoutIfNeeded];
        }];
    }
}

#pragma mark - lazy load
- (HTCommentGetter *)commentGetter {
    if (!_commentGetter) {
        _commentGetter = [[HTCommentGetter alloc] initWithPostId:self.post_id];
    }
    return _commentGetter;
}

- (HTNoCommentFooterView *)noCommentsFooterView {
    if (!_noCommentsFooterView) {
        _noCommentsFooterView = [HTNoCommentFooterView footerViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    }
    return _noCommentsFooterView;
}

@end
