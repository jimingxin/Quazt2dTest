//
//  LZArcView.m
//  绘制路径
//
//  Created by 嵇明新 on 16/5/10.
//  Copyright © 2016年 lanhe. All rights reserved.
//

#import "LZArcView.h"

@implementation LZArcView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)drawRect:(CGRect)rect{
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();//获得当前上下文对象
    CGContextBeginPath(ctx);
    //CGContextAddRoundRect(ctx, 25, 25,200,100,10);
    //CGContextAddFlower(ctx, 6, 50, 100, 30, 50);
    CGContextClosePath(ctx);
    
    CGContextSetRGBFillColor(ctx, 1, 0, 1, 1);
    CGContextSetRGBStrokeColor(ctx, 1, 1, 0, 1);
    CGContextSetLineWidth(ctx, 3);
    //CGContextStrokePath(ctx);
    CGContextDrawPath(ctx, kCGPathFillStroke);
    CGContextFillPath(ctx);
    
}




@end
