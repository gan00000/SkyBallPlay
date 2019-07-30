//
//  UIImage+SVG.h
//  SkyBallPlay
//
//  Created by ganyuanrong on 2019/7/30.
//  Copyright © 2019 Dean_F. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SVGKit/SVGKImage.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (SVG)


- (void)svg_setImageWithURL:(nullable NSURL *)url placeholderImage:(nullable UIImage *)placeholder;

@end

NS_ASSUME_NONNULL_END
