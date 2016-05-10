//
//  QuaztContext.h
//  绘制路径
//
//  Created by 嵇明新 on 16/5/10.
//  Copyright © 2016年 lanhe. All rights reserved.
//

#ifndef QuaztContext_h
#define QuaztContext_h

/**
 *  该方法负责绘制花朵 n 花朵的花瓣数 dx dy 花朵的位置 size 控制花朵的大小 length 花瓣的长度
 *
 *  @param c
 *  @param n
 *  @param dx
 *  @param dy
 *  @param size
 *  @param length
 */
void CGContextAddFlower(CGContextRef c, NSInteger n, CGFloat dx, CGFloat dy, CGFloat size, CGFloat length){

    CGContextMoveToPoint(c, dx, dy + size);
    
    CGFloat dig = 2 * M_PI /n;
    for (int i = 1; i < n; i++) {
        //计算控制点的坐标
        CGFloat ctr1X = sin((i - 0.5) * dig) * length + dx;
        CGFloat ctr1Y = cos((i - 0.5) * dig) * length + dy;
        //计算结束点的坐标
        CGFloat x = sin(i * dig) * size + dx;
        CGFloat y = cos(i * dig) * size + dy;
        
        //添加二次曲线的路径
        CGContextAddQuadCurveToPoint(c, ctr1X, ctr1Y, x, y);
        
    }
}


/**
 *  绘制多边形 c 图形上下文 n 多边形边数 dx 多边形中心点 X值 dy 多边形中心点 Y值 size 多边形边长
 *
 *  @param c
 *  @param n
 *  @param dx
 *  @param dy
 *  @param size
 */
void CGContextAddStar(CGContextRef c, NSInteger n, CGFloat dx, CGFloat dy, NSInteger size){
    
    CGFloat dig = 4 * M_PI / n;
    CGContextMoveToPoint(c, dx, dy + size);
    for (int i = 1; i <= n; i++) {
        CGFloat x = sin(i * dig);
        CGFloat y = cos(i * dig);
        CGContextAddLineToPoint(c, x * size + dx, y * size + dy);
    }
}


/**
 *  该方法绘制圆角矩形 x1、y1 是圆角矩形左上角的坐标，width,height 控制圆角矩形的宽和高
 *  radius:控制圆角矩形的四个圆角的半径
 *  @param c      图形上下文对象
 *  @param x1
 *  @param y1
 *  @param width
 *  @param height
 *  @param radius
 */
void CGContextAddRoundRect(CGContextRef c, CGFloat x1,CGFloat y1, CGFloat width, CGFloat height, CGFloat radius ){
    
    CGContextMoveToPoint(c, x1 + radius, y1);
    CGContextAddLineToPoint(c, x1 + width - radius, y1);//添加一条连接到左上角的线段
    //添加一段圆弧
    CGContextAddArcToPoint(c, x1+width, y1, x1+width, y1+radius, radius);
    //添加一条连接到右下角的线段
    CGContextAddLineToPoint(c, x1+width, y1+height-radius);
    
    //添加右下角的圆弧
    CGContextAddArcToPoint(c, x1+width, y1+height, x1+width-radius, y1+height, radius);
    //添加一条连接到左下角的线段
    CGContextAddLineToPoint(c, x1+radius, y1+height);
    
    //添加左下角的圆弧
    CGContextAddArcToPoint(c, x1, y1+height, x1, y1+height-radius, radius);
    //添加一条连接到左上角的线段
    CGContextAddLineToPoint(c, x1, y1+radius);
    
    //添加左上角的圆弧
    CGContextAddArcToPoint(c, x1, y1, x1+radius, y1, radius);
    
}




/**
 *  画圆弧
 */
void drawArc(){
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    for (int i = 0; i < 10; i++) {
        CGContextBeginPath(ctx); //开始定义路径
        //添加一段圆弧，最后一个参数1代表逆时针，0代表顺时针
        CGContextAddArc(ctx, i*25, i*25, (i+1)*8, M_PI * 1.5, M_PI, 1);
        CGContextClosePath(ctx);//关闭路径
        CGContextSetRGBFillColor(ctx, 1, 0, 1, (10-i)*0.1);//设置颜色
        CGContextDrawPath(ctx, kCGPathFill);
        
    }
    
}

#endif /* QuaztContext_h */
