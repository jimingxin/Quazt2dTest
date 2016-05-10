//
//  LZDrawView.m
//  绘制路径
//
//  Created by 嵇明新 on 16/5/10.
//  Copyright © 2016年 lanhe. All rights reserved.
//

#import "LZDrawView.h"
#import "QuaztContext.h"

@implementation LZDrawView

CGPoint firstTouch,prevTouch,lastTouch;

//定义向内存中的图片执行绘图的CGContextRef
CGContextRef buffCtx;
UIImage *image;

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        _currentColor = [UIColor redColor];
        UIGraphicsBeginImageContext(self.bounds.size);
        buffCtx = UIGraphicsGetCurrentContext();
    }
    return  self;
}

//当用户手指开始触碰时激发该方法
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    UITouch *touch = [touches anyObject];
    firstTouch = [touch locationInView:self];//获取碰触点的坐标
    //如果当前正在进行自由绘制，prevtouch 代表第一个触碰点
    if (self.shape == kPenShape) {
        prevTouch = firstTouch;
    }
    
}

//当用户手指在控件上拖动时不断激发该方法
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    lastTouch = [touch locationInView:self];
    //如果当前正在进行自由绘制
    if (self.shape == kPenShape) {
        [self draw:buffCtx];//向内存中的图片执行绘制
        image = UIGraphicsGetImageFromCurrentImageContext();
        
    }
    
    //通知该控件重绘，此时会实时绘制起始点与用户手指拖动点之间的形状
    [self setNeedsDisplay];
}

//当用户手指离开控件时激发该方法
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    lastTouch = [touch locationInView:self];
    
    //向内存中的图片执行绘制，即把最终确定的图形绘制到内存中的图片上
    [self draw:buffCtx];
    image = UIGraphicsGetImageFromCurrentImageContext();
    [self setNeedsDisplay];//通知重绘
}

-(void)drawRect:(CGRect)rect{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [image drawAtPoint:CGPointZero];
    [self draw:ctx];
}

-(CGRect) curRect{
    return CGRectMake(firstTouch.x, firstTouch.y, lastTouch.x - firstTouch.x, lastTouch.y - firstTouch.y);
}
    
-(void) draw:(CGContextRef)ctx {
    //设置线条的颜色
    CGContextSetStrokeColorWithColor(ctx, self.currentColor.CGColor);
    CGContextSetFillColorWithColor(ctx, self.currentColor.CGColor);
    CGContextSetLineWidth(ctx, 2.0);//设置线宽
    CGContextSetShouldAntialias(ctx, YES);
    CGFloat leftTopX;
    CGFloat leftTopY;
    
    switch (self.shape) {
           
        case kLineShape:
            //添加从firstTouch 到lastTouch的路径
            CGContextMoveToPoint(ctx, firstTouch.x, firstTouch.y);
            CGContextAddLineToPoint(ctx, lastTouch.x, lastTouch.y);
            CGContextStrokePath(ctx);
            break;
        case kRectShape:
            CGContextFillRect(ctx, [self curRect]);
            break;
        case kEllipseShape:
            CGContextFillEllipseInRect(ctx, [self curRect]);
            break;
        case kRoundRectShape:
            //计算左上角的坐标
            leftTopX = firstTouch.x < lastTouch.x ? firstTouch.x:lastTouch.x;
            leftTopY = firstTouch.y < lastTouch.y ? firstTouch.y:lastTouch.y;
            
            //添加圆角矩形的路径
            CGContextAddRoundRect(ctx, leftTopX, leftTopY, fabs(lastTouch.x - firstTouch.x), fabs(lastTouch.y - firstTouch.y), 16);
            CGContextFillPath(ctx);
            break;
        case kPenShape:
            //添加从Prevtouch到lasttouch的路径
            CGContextMoveToPoint(ctx, prevTouch.x, prevTouch.y);
            CGContextAddLineToPoint(ctx, lastTouch.x, lastTouch.y);
            CGContextStrokePath(ctx);
            prevTouch = lastTouch;
            break;
        default:
            break;
    }
    
   
}






























@end
