//
//  ViewController.m
//  UI组件_定制UIActionSheet
//
//  Created by ZengSanchain on 2016/11/7.
//  Copyright © 2016年 ziFei. All rights reserved.
//

#import "ViewController.h"
#import "SCActionSheet.h"


@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}


- (IBAction)btnClick:(UIButton *)sender {
    
    /**
     *  使用方法
     *
     */
    
    // 两行
//    [[SCActionSheet shareManager] actionSheetWithTopTitle:@"拍照" topBtnClickBlock:^{
//        NSLog(@"Viewcontroller Click topAction ");
//    }];
    
    
    // 3行
    [[SCActionSheet shareManager] actionSheetWithTopTitle:@"其它方式登录" bottomTitle:@"验证码登录" topBtnClickBlock:^{
        NSLog(@"Viewcontroller Click topAction ");
        
    } bottomBtnClickBlock:^{
        NSLog(@"Viewcontroller Click bottomAction ");
    }];
    
    
    // 4行
//    [[SCActionSheet shareManager] actionSheetWithTopTitle:@"小视频" middleTitle:@"拍照" bottomTitle:@"从手机相册选择" topBtnClickBlock:^{
//        NSLog(@"topBtnClickBlock");
//        
//    } middleClickBlock:^{
//        NSLog(@"middleClickBlock");
//        
//    } bottomBtnClickBlock:^{
//        NSLog(@"bottomBtnClickBlock");
//    }];
}



@end
