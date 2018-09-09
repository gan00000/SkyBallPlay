//
//  HTMatchHomeRequest.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/9.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "HTMatchHomeRequest.h"

@implementation HTMatchHomeRequest

+ (void)requestWithStartDate:(NSString *)startDate
                     endDate:(NSString *)endDate
                successBlock:(void(^)(NSArray<HTMatchHomeGroupModel *> *matchList))successBlock
                  errorBlock:(BJServiceErrorBlock)errorBlock {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"date_from"] = startDate;
    params[@"date_to"] = endDate;
    
    [BJHTTPServiceEngine getRequestWithFunctionPath:API_MATCH_HOME params:params successBlock:^(id responseData) {
        NSArray *allMatchList = [NSArray yy_modelArrayWithClass:[HTMatchHomeModel class] json:responseData[@"matches"]];
        NSMutableArray *groupedMatchList = [NSMutableArray array];
        NSMutableArray *matchList;
        NSString *groupName = @"";
        
        for (HTMatchHomeModel *matchModel in allMatchList) {
            if (![matchModel.date isEqualToString:groupName]) {
                matchList = [NSMutableArray array];
                
                HTMatchHomeGroupModel *groupModel = [[HTMatchHomeGroupModel alloc] init];
                groupModel.groupName = matchModel.date;
                groupModel.matchList = matchList;
                [groupedMatchList addObject:groupModel];
                
                groupName = groupModel.groupName;
            }
            
            [matchList addObject:matchModel];
        }
        
        if (successBlock) {
            successBlock(groupedMatchList);
        }
    } errorBlock:errorBlock];
}

@end
