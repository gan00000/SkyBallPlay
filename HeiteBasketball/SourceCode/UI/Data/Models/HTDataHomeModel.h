//
//  HTDataHomeModel.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/11.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTDataHomeModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *teamName;
@property (nonatomic, copy) NSString *officialImagesrc;
@property (nonatomic, assign) CGFloat score;

@end
