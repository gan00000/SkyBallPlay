//
//  HTMyMessageModel.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2019/4/9.
//  Copyright © 2019 Dean_F. All rights reserved.
//

#import "HTMyMessageModel.h"

@implementation HTMyMessageModel

- (void)countHeight {
    if ([self.type isEqualToString:@"like"]) {
        _desc = [NSString stringWithFormat:@"%@點讚了你的評論：%@", self.display_name, self.comment_content];
        _cellHeight = 105;
    } else {
        _desc = [NSString stringWithFormat:@"%@回復了你的評論：%@", self.display_name, self.comment_content];
        CGFloat height = [self.reply_msg jx_sizeWithFont:[UIFont systemFontOfSize:15] constrainedToWidth:SCREEN_WIDTH - 30].height;
        _cellHeight = height + 125;
    }
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    _date = [format dateFromString:self.created_on];
}

@end
