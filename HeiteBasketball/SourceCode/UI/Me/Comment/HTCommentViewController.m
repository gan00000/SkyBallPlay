//
//  HTCommentViewController.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2019/4/5.
//  Copyright © 2019 Dean_F. All rights reserved.
//

#import "HTCommentViewController.h"

@interface HTCommentViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation HTCommentViewController

+ (instancetype)viewController {
    return [[HTCommentViewController alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的評論";
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
