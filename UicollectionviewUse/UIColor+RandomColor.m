//
//  UIColor+RandomColor.m
//  SDLearning
//
//  Created by Xia_Q on 16/6/17.
//  Copyright © 2016年 X. All rights reserved.
//

#import "UIColor+RandomColor.h"

@implementation UIColor (RandomColor)

+(UIColor*) randomColor{
    
    CGFloat hue = arc4random() % 256 / 256.0; //色调随机:0.0 ~ 1.0
    CGFloat saturation = (arc4random() % 128 / 256.0) + 0.5; //饱和随机:0.5 ~ 1.0
    CGFloat brightness = (arc4random() % 128 / 256.0) + 0.5; //亮度随机:0.5 ~ 1.0
    
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

@end
