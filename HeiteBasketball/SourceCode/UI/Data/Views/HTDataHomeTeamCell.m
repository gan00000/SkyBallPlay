//
//  HTDataHomeTeamCell.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/14.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "HTDataHomeTeamCell.h"
#import "HTDataCellTeamView.h"

@interface HTDataHomeTeamCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;
@property (weak, nonatomic) IBOutlet UIView *cellContentView;

@property (nonatomic, strong) NSMutableArray *cells;

@end

@implementation HTDataHomeTeamCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.clipsToBounds = YES;
    self.arrowImageView.image = [self.arrowImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
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
    
    CGFloat width = SCREEN_WIDTH / datas.count;
    for (NSInteger i=self.cells.count; i<datas.count; i++) {
        HTDataCellTeamView *cell = [HTDataCellTeamView dataCellViewWithFrame:CGRectMake(i*width, 0, width, self.cellContentView.jx_height)
                                                                       addToView:self.cellContentView];
        [self.cells addObject:cell];
    }
    
    for (NSInteger i=0; i<datas.count; i++) {
        HTDataHomeModel *model = datas[i];
        HTDataCellTeamView *cell = self.cells[i];
        [cell setupWithDataModel:model];
    }
}

- (IBAction)onDetailButtonTapped:(UIButton *)sender {
    if (self.showMoreBlock) {
        self.showMoreBlock();
    }
}

- (NSMutableArray *)cells {
    if (!_cells) {
        _cells = [NSMutableArray array];
    }
    return _cells;
}

@end
