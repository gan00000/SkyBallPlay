//
//  HTDataHomeCell.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/13.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "HTDataHomeCell.h"
#import "HTDataCellView.h"

@interface HTDataHomeCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;
@property (weak, nonatomic) IBOutlet HTDataCellView *cell1;
@property (weak, nonatomic) IBOutlet HTDataCellView *cell2;
@property (weak, nonatomic) IBOutlet HTDataCellView *cell3;
@property (weak, nonatomic) IBOutlet HTDataCellView *cell4;
@property (weak, nonatomic) IBOutlet HTDataCellView *cell5;

@property (nonatomic, strong) NSArray *cells;

@end

@implementation HTDataHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.arrowImageView.image = [self.arrowImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.cells = @[self.cell1, self.cell2, self.cell3, self.cell4, self.cell5];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupWithTitle:(NSString *)title datas:(NSArray<HTDataHomeModel *> *)datas {
    if (datas.count == 0) {
        return;
    }
    
    self.titleLabel.text = title;
    
    for (NSInteger i=0; i<datas.count; i++) {
        HTDataHomeModel *model = datas[i];
        HTDataCellView *cell = self.cells[i];
        [cell setupWithDataModel:model];
    }
}

- (IBAction)onDetailButtonTapped:(UIButton *)sender {
    if (self.showMoreBlock) {
        self.showMoreBlock();
    }
}

@end
