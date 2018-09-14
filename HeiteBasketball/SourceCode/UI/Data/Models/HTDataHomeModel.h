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
@property (nonatomic, copy) NSString *team_logo;
@property (nonatomic, copy) NSString *html_team_logo;
@property (nonatomic, assign) CGFloat score;

- (void)imageUrlFixWithWidth:(NSInteger)width;

@end
