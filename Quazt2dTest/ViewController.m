//
//  ViewController.m
//  绘制路径
//
//  Created by 嵇明新 on 16/5/10.
//  Copyright © 2016年 lanhe. All rights reserved.
//

#import "ViewController.h"
#import "LZDrawView.h"
NSArray *colors;
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    //设置初始化颜色
    self.view.backgroundColor = [UIColor whiteColor];
    colors = [NSArray arrayWithObjects:[UIColor redColor] ,[UIColor greenColor],[UIColor blueColor],[UIColor yellowColor],[UIColor purpleColor],[UIColor cyanColor],[UIColor blueColor],nil];
    
    [super viewDidLoad];
    
}

-(IBAction)changeColor:(UISegmentedControl*)sender{
    ((LZDrawView *)self.view).currentColor = [colors objectAtIndex:sender.selectedSegmentIndex];
}

-(IBAction)changeShape:(UISegmentedControl *)sender{
    ((LZDrawView *)self.view).shape =  sender.selectedSegmentIndex;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
