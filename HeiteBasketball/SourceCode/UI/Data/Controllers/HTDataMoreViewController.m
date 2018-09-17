//
//  HTDataMoreViewController.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/17.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "HTDataMoreViewController.h"

@interface HTDataMoreViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation HTDataMoreViewController

+ (instancetype)viewController {
    return kLoadStoryboardWithName(@"DataMore");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private
- (void)setupViews {
    self.title = @"更多";
    
}

@end
