//
//  UIImage+SVG.m
//  SkyBallPlay
//
//  Created by ganyuanrong on 2019/7/30.
//  Copyright © 2019 Dean_F. All rights reserved.
//

#import "UIImageView+SVG.h"

@implementation UIImageView (SVG)

- (void)svg_setImageWithURL:(nullable NSURL *)url placeholderImage:(nullable UIImage *)placeholder {
    
    SVGKImage *theSvgImage = [SVGKImage imageWithData:[NSData dataWithContentsOfURL:url]];
    if (theSvgImage && theSvgImage.UIImage) {
        [self setImage:theSvgImage.UIImage];
    }else
    {
        [self setImage:placeholder];
        
    }
    
    
}
   

@end
