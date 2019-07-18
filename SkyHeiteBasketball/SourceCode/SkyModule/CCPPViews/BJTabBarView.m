//
//  BJTabBarView.m
//  BenjiaPro
//
//  Created by 冯生伟 on 2018/6/15.
//  Copyright © 2018年 冯生伟. All rights reserved.
//

#import "BJTabBarView.h"

@interface BJTabBarView ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *selectedMarkView;

@property (nonatomic, copy) NSArray *tabTitles;
@property (nonatomic, strong) NSMutableArray *tabButtons;

@end

@implementation BJTabBarView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
}

@end
