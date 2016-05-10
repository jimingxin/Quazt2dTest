//
//  LZDrawView.h
//  绘制路径
//
//  Created by 嵇明新 on 16/5/10.
//  Copyright © 2016年 lanhe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constrant.h"


@interface LZDrawView : UIView

@property (nonatomic, strong) UIColor *currentColor;

@property (nonatomic, assign) ShapeType shape;

@end
