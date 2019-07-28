
#import "HTTabBarHomeViewController.h"
#import "HTUserInfoEditViewController.h"
#import "HTCollectionViewController.h"
#import "HTCommentViewController.h"
#import "HTLikeViewController.h"
#import "HTHistoryViewController.h"
#import "HTMessageViewController.h"
#import "HTSettingViewController.h"

// cells
#import "HTMeCenterHeaderCell.h"
#import "HTMeCenterItemsCell.h"
#import "HTMeCenterNormalCell.h"
#import "HTUserRequest.h"

@interface HTTabBarHomeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) NSInteger messageCount;

@end

@implementation HTTabBarHomeViewController

+ (instancetype)skargviewController {
    return [[HTTabBarHomeViewController alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的";
    [self.navigationController.navigationBar setupBackground];
    [self setupTableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onUserLogStatusChagne)
                                                 name:kUserLogStatusChagneNotice
                                               object:nil];
    [HTUserRequest skargrequestUnReadMessageCountWithSuccessBlock:^(NSInteger count) {
        self.messageCount = count;
        [self.tableView reloadData];
    } failBlock:nil];
    
    self.skargmeCenterButton.hidden = YES;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)onUserLogStatusChagne {
    [self.tableView reloadData];
}

- (void)setupTableView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HTMeCenterHeaderCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([HTMeCenterHeaderCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HTMeCenterItemsCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([HTMeCenterItemsCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HTMeCenterNormalCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([HTMeCenterNormalCell class])];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    kWeakSelf
    if (indexPath.row == 0) {
        HTMeCenterHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HTMeCenterHeaderCell class])];
        [cell skarg_refreshUI];
        return cell;
    }
    if (indexPath.row == 1) {
        HTMeCenterItemsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HTMeCenterItemsCell class])];
        cell.onItemTappedBlock = ^(NSInteger index) {
            UIViewController *viewController;
            switch (index) {
                    case 0: {
                        viewController = [HTCollectionViewController skargviewController];
                    } break;
                    
                    case 1: {
                        viewController = [HTCommentViewController skargviewController];
                    } break;
                    
                    case 2: {
                        viewController = [HTLikeViewController skargviewController];
                    } break;
                    
                    case 3: {
                        viewController = [HTHistoryViewController skargviewController];
                    } break;
                    
                default:
                    break;
            }
            [weakSelf.navigationController pushViewController:viewController animated:YES];
        };
        return cell;
    }
    if (indexPath.row == 2) {
        HTMeCenterNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HTMeCenterNormalCell class])];
        cell.title = @"消息通知";
        cell.messageCount = self.messageCount;
        return cell;
    }
    HTMeCenterNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HTMeCenterNormalCell class])];
    cell.title = @"系統設置";
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (![HTUserManager skarg_isUserLogin]) {
        [HTUserManager skarg_doUserLogin];
        return;
    }
    
    UIViewController *viewController;
    if (indexPath.row == 0) {
        viewController = [HTUserInfoEditViewController skargviewController];
    }
    if (indexPath.row == 2) {
        viewController = [HTMessageViewController skargviewController];
    }
    if (indexPath.row == 3) {
        viewController = [HTSettingViewController skargviewController];
    }
    [self.navigationController pushViewController:viewController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 || indexPath.row == 1) {
        return 110;
    }
    return 55;
}

@end
