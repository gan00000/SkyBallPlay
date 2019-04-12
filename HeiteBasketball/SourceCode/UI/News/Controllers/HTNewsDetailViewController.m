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
#import "BJNavigationController.h"
#import "HTNewsAdditionRequest.h"
#import "HTUserRequest.h"
#import <BlocksKit/BlocksKit.h>
#import <YYText/YYText.h>

@interface HTNewsDetailViewController () <UITableViewDelegate, UITableViewDataSource, BJNavigationDelegate>

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

@property (nonatomic, strong) NSArray *topNewsList;
@property (nonatomic, strong) NSArray *hotComments;
@property (nonatomic, strong) NSArray *comments;
@property (nonatomic, copy) NSString *htmlContent;
@property (nonatomic, assign) CGFloat newsContentHeight;
@property (nonatomic, assign) BOOL topRequestDone;
@property (nonatomic, assign) BOOL htmlLoadDone;
@property (nonatomic, assign) BOOL commentRequestDone;
@property (nonatomic, assign) NSInteger commentOffset;
@property (nonatomic, weak) HTCommentModel *currentCommentModel;

@end

@implementation HTNewsDetailViewController

+ (instancetype)viewController {
    return kLoadStoryboardWithName(@"NewsDetail");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
    [self loadData];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if ([self.commentInputView.text isEqualToString:@" "]) {
        self.commentInputView.text = nil;
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return self.topNewsList.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        HTNewsHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTNewsHeaderCell"];
        [cell setupWithNewsModel:self.newsModel];
        return cell;
    } else if (indexPath.section == 1) {
        kWeakSelf
        HTNewsWebCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTNewsWebCell"];
        [cell setupWithClearHtmlContent:self.htmlContent];
        cell.onContentHeightUpdateBlock = ^(CGFloat height) {
            if (fabs(height - weakSelf.newsContentHeight) < 1) {
                return;
            }
            weakSelf.newsContentHeight = height;
            [weakSelf.tableView reloadData];
        };
        return cell;
    }
    HTNewsHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTNewsHomeCell"];
    [cell setupWithNewsModel:self.topNewsList[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        HTNewsModel *newsModel = self.topNewsList[indexPath.row];
        
        HTNewsDetailViewController *detailVc = [HTNewsDetailViewController viewController];
        detailVc.newsModel = newsModel;
        [self.navigationController pushViewController:detailVc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return self.newsModel.detailHeaderHeight;
    } else if (indexPath.section == 1) {
        return self.newsContentHeight;
    }
    return 90;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 2) {
        return 40;
    }
    return 0.1;
}

- (UITableViewHeaderFooterView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 2) {
        HTNewsTopHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"HTNewsTopHeaderView"];
        return headerView;
    }
    return nil;
}

#pragma mark - private
- (void)setupViews {
    self.title = @"新聞詳情";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
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
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.newsContentHeight = 300;
    self.topRequestDone = NO;
    self.htmlLoadDone = NO;
    self.commentRequestDone = NO;
    self.commentOffset = 0;
    
    [self.view showLoadingView];
    
    if ([HTNewsModel canShare]) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_icon_share"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] style:UIBarButtonItemStylePlain target:self action:@selector(onShareButtonTapped:)];
    }
    
    UIImage *commentIcon = [[UIImage imageNamed:@"icon_add_comment"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.commentButton setImage:commentIcon forState:UIControlStateNormal];
    [self.commentButton setTintColor:[UIColor hx_colorWithHexRGBAString:@"999999"]];
    UIImage *saveIcon = [[BJBaseViewController fixImageSize:[UIImage imageNamed:@"icon_add_collection"] toSize:CGSizeMake(20, 20)] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.saveButton setImage:saveIcon forState:UIControlStateNormal];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onInputBegin) name:UITextViewTextDidBeginEditingNotification object:self.commentInputView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onInputEnd) name:UITextViewTextDidEndEditingNotification object:self.commentInputView];
    
    kWeakSelf
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

- (void)loadData {
    kWeakSelf
    [HTNewsTopRequest requestWithSuccessBlock:^(NSArray<HTNewsModel *> *newsList) {
        weakSelf.topNewsList = newsList;
        weakSelf.topRequestDone = YES;
        [weakSelf refreshUI];
    } errorBlock:^(BJError *error) {
        [weakSelf.view showToast:@"「推薦閱讀」獲取失敗"];
        weakSelf.topRequestDone = YES;
        [weakSelf refreshUI];
    }];
    
    [self.newsModel getClearContentWithBlock:^(BOOL success, NSString *content) {
        weakSelf.htmlContent = content;
        weakSelf.htmlLoadDone = YES;
        [weakSelf refreshUI];
    }];
    
    [HTNewsAdditionRequest requestAllCommentWithPostId:self.newsModel.news_id successBlock:^(NSArray<HTCommentModel *> * _Nonnull commentList, NSArray<HTCommentModel *> * _Nonnull hotComments) {
        self.commentRequestDone = YES;
        self.hotComments = hotComments;
        self.comments = commentList;
        [self refreshUI];
    } failBlock:^(BJError *error) {
        [self.view showToast:@"「評論」獲取失敗"];
        weakSelf.topRequestDone = YES;
        [weakSelf refreshUI];
    }];
    [HTUserRequest addHistoryWithNewsId:self.newsModel.news_id successBlock:^{
        BJLog(@"添加瀏覽歷史成功");
    } failBlock:^(BJError *error) {
        BJLog(@"添加瀏覽歷史失敗");
    }];
}

- (void)refreshUI {
    if (!self.topRequestDone || !self.htmlLoadDone || !self.commentRequestDone) {
        return;
    }
    
    [self.view hideLoadingView];
    [self.tableView reloadData];
    
    [self setupSaveButton];
    
    NSInteger count = self.comments.count + self.hotComments.count;
    if (count > 0) {
        self.commentCountContent.hidden = NO;
        self.commentCountLabel.text = [NSString stringWithFormat:@"%ld", count];
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
    if (![HTUserManager isUserLogin]) {
        [HTUserManager doUserLogin];
        [self.view showToast:@"請登錄"];
        return;
    }
    if (sender.selected) {
        [HTUserRequest deleteCollectionWithNewsId:self.newsModel.news_id successBlock:^{
            [self.view showToast:@"已取消收藏"];
            self.newsModel.my_save = NO;
            [self setupSaveButton];
        } failBlock:^(BJError *error) {
            [self.view showToast:@"取消收藏失敗"];
        }];
    } else {
        [HTUserRequest addCollectionWithNewsId:self.newsModel.news_id successBlock:^{
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

- (IBAction)onCommentAction:(id)sender {
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
    
    [HTUserRequest postCommentWithComment_txt:self.commentInputView.text post_id:self.newsModel.news_id reply_comment_id:self.currentCommentModel.comment_id successBlock:^{
        self.commentInputView.text = nil;
        [self.view endEditing:YES];
        [kWindow showToast:@"評論成功"];
    } failBlock:^(BJError *error) {
        [kWindow showToast:@"評論失敗"];
    }];
}

- (void)onInputBegin {
    if (![HTUserManager isUserLogin]) {
        [self.view endEditing:YES];
        [HTUserManager doUserLogin];
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

#pragma mark - BJNavigationDelegate
- (BOOL)bj_shouldHandlePopActionMySelf {
    return YES;
}

- (void)bj_handlePopActionMySelf {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
