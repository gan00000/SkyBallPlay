//
//  HTMessageViewController.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2019/4/5.
//  Copyright © 2019 Dean_F. All rights reserved.
//

#import "HTMessageViewController.h"

@interface HTMessageViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation HTMessageViewController

+ (instancetype)viewController {
    return [[HTMessageViewController alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"消息通知";
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
