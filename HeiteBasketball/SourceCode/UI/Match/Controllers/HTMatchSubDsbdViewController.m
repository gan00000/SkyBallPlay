//
//  HTMatchSubDsbdViewController.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/10/14.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "HTMatchSubDsbdViewController.h"

@interface HTMatchSubDsbdViewController ()

@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollContentView;

@property (nonatomic, strong) UITableView *rightTableView;

@end

@implementation HTMatchSubDsbdViewController

+ (instancetype)viewController {
    return kLoadStoryboardWithName(@"MatchSubDsbd");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)refreshWithDetailList:(NSArray<HTMatchDetailsModel *> *)detailList {
    
}

@end
