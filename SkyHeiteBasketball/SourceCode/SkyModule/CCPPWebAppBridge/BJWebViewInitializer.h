//
//  BJWebViewInitializer.h
//  BenjiaPro
//
//  Created by Marco on 2017/10/31.
//  Copyright © 2017年 Benjia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BJWebViewInitializer : NSObject

+ (instancetype)sharedInstance;

- (void)setupWebViewWithCompletion:(void(^)(void))completion;

@end
