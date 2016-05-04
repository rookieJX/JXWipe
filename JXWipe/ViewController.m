//
//  ViewController.m
//  JXWipe
//
//  Created by yuezuo on 16/5/4.
//  Copyright © 2016年 yuezuo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageViewOne;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewTwo;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:pan];
}

- (void)pan:(UIPanGestureRecognizer *)gesture {
    
#warning 注意在这里我们擦除的时候不可以有约束，否则会在擦除图片的同时计算约束，会出现图片，我们只可以设置图片的frame
    // 获取当前点
    CGPoint currentP = [gesture locationInView:self.view];
    CGFloat clearW = 10;
    CGFloat clearH = clearW;
    CGFloat clearX = currentP.x - clearW * 0.5;
    CGFloat clearY = currentP.y - clearH * 0.5;
    CGRect rect = CGRectMake(clearX, clearY, clearW, clearH);
    // 获取上下文
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, 0);

    // 渲染
    CGContextRef ctf = UIGraphicsGetCurrentContext();
    
    [self.imageViewTwo.layer renderInContext:ctf];
    
    // 设置裁剪区域
    CGContextClearRect(ctf, rect);
    
    self.imageViewTwo.image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭
    UIGraphicsEndImageContext();
    
    

}
@end
