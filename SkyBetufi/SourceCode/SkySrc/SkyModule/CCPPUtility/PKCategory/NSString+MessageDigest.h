//
//  NSString+MessageDigest.h
//  Exchange
//
//  Created by Marco on 2017/3/8.
//  Copyright © 2017年 zhugelicai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MessageDigest)

- (NSString *)MD2;
- (NSString *)MD4;
- (NSString *)MD5;

- (NSString *)SHA1;
- (NSString *)SHA224;
- (NSString *)SHA256;
- (NSString *)SHA384;
- (NSString *)SHA512;

@end
