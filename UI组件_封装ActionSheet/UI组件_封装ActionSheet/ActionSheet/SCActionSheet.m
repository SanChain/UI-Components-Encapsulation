//
//  SCActionSheet.m
//  UI组件_定制UIActionSheet
//
//  Created by ZengSanchain on 2016/11/7.
//  Copyright © 2016年 ziFei. All rights reserved.
//

#import "SCActionSheet.h"
#import "Masonry.h"


#define KCONTENTVIEW_HEIGHT_TWOROWS 120 // 两行时 contentView的高度
#define KCONTENTVIEW_HEIGHT_THIRDROWS 160 // 3行时 contentView的高度
#define KCONTENTVIEW_HEIGHT_FOURTHROWS 190 // 4行时 contentView的高度

#define KMAINSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define KMAINSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width



@interface SCActionSheet ()
@property (strong, nonatomic) UIView *contV; /**<  */
@end

@implementation SCActionSheet

+ (instancetype)shareManager {
    static SCActionSheet *actSheet = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        actSheet = [[SCActionSheet alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [actSheet setWindowLevel:UIWindowLevelStatusBar];
        [actSheet setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.7]];
        [actSheet setHidden:NO];
        [actSheet setRootViewController:[[UIViewController alloc] init]];
        
        // 为UIWindow添加手势
        UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] init];
        [gesture addTarget:actSheet action:@selector(tapWindow)];
        [actSheet addGestureRecognizer:gesture];
    });
    
    return actSheet;
}


- (void)actionSheetWithTopTitle:(NSString *)topTitle
               topBtnClickBlock:(SCTopBtnBlock)topBtnClickBlock {
    
    _topBtnBlock = topBtnClickBlock;
    [[SCActionSheet shareManager] setHidden:NO];
    
    // 添加subViews
    UIView *contV = [[UIView alloc] initWithFrame:CGRectMake(0, KMAINSCREEN_HEIGHT, KMAINSCREEN_WIDTH, KCONTENTVIEW_HEIGHT_TWOROWS)];
    UIColor *color = [UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.0];
    [contV setBackgroundColor:color];
    [[SCActionSheet shareManager] addSubview:contV];
    [SCActionSheet shareManager].contV = contV;
    
    
    UIColor *btnBgColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1.0];
    // Top UIButton
    UIButton *firBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [firBtn setTag:0];
    [firBtn.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [firBtn setTitle:topTitle forState:UIControlStateNormal];
    [firBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [firBtn addTarget:[SCActionSheet shareManager] action:@selector(twoRowBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [firBtn setBackgroundColor:[UIColor whiteColor]];
    [firBtn setBackgroundImage:[self createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [firBtn setBackgroundImage:[self createImageWithColor:btnBgColor] forState:UIControlStateHighlighted];
    [[SCActionSheet shareManager].contV addSubview:firBtn];

    
    // Cancle UIButton
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleBtn setTag:1];
    [cancleBtn.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancleBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [cancleBtn addTarget:[SCActionSheet shareManager] action:@selector(twoRowBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cancleBtn setBackgroundColor:[UIColor whiteColor]];
    [cancleBtn setBackgroundImage:[self createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [cancleBtn setBackgroundImage:[self createImageWithColor:btnBgColor] forState:UIControlStateHighlighted];
    [[SCActionSheet shareManager].contV addSubview:cancleBtn];
    
    // 约束
    [firBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo([SCActionSheet shareManager].contV.mas_top).with.offset(0);
        make.left.equalTo([SCActionSheet shareManager].contV.mas_left).with.offset(0);
        make.right.equalTo([SCActionSheet shareManager].contV.mas_right).with.offset(0);
        make.height.equalTo(cancleBtn.mas_height);
    }];
    
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firBtn.mas_bottom).with.offset(6);
        make.left.equalTo([SCActionSheet shareManager].contV.mas_left).with.offset(0);
        make.right.equalTo([SCActionSheet shareManager].contV.mas_right).with.offset(0);
        make.bottom.equalTo([SCActionSheet shareManager].contV.mas_bottom);
    }];
    
    
    [UIView animateWithDuration:0.5 delay:0.2 usingSpringWithDamping:0.8 initialSpringVelocity:0.5 options:UIViewAnimationOptionTransitionCurlUp animations:^{
        [[SCActionSheet shareManager].contV setFrame:CGRectMake(0, KMAINSCREEN_HEIGHT - KCONTENTVIEW_HEIGHT_TWOROWS, KMAINSCREEN_WIDTH, KCONTENTVIEW_HEIGHT_TWOROWS)];
    } completion:^(BOOL finished) {
    }];
}

- (void)actionSheetWithTopTitle:(NSString *)topTitle
                    bottomTitle:(NSString *)bottomTitle
               topBtnClickBlock:(SCTopBtnBlock)topBtnClickBlock
            bottomBtnClickBlock:(SCBottomBtnBlock)bottomBtnClickBlock {
    
    _topBtnBlock = topBtnClickBlock;
    _bottomBtnBlock = bottomBtnClickBlock;
    [[SCActionSheet shareManager] setHidden:NO];
    
    // 添加subViews
    UIView *contV = [[UIView alloc] initWithFrame:CGRectMake(0, KMAINSCREEN_HEIGHT, KMAINSCREEN_WIDTH, KCONTENTVIEW_HEIGHT_THIRDROWS)];
    UIColor *color = [UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.0];
    [contV setBackgroundColor:color];
    [[SCActionSheet shareManager] addSubview:contV];
    [SCActionSheet shareManager].contV = contV;
    
    
    UIColor *btnBgColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1.0];
    // Top UIButton
    UIButton *firBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [firBtn setTag:0];
    [firBtn.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [firBtn setTitle:topTitle forState:UIControlStateNormal];
    [firBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [firBtn addTarget:[SCActionSheet shareManager] action:@selector(threeRowBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [firBtn setBackgroundColor:[UIColor whiteColor]];
    [firBtn setBackgroundImage:[self createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [firBtn setBackgroundImage:[self createImageWithColor:btnBgColor] forState:UIControlStateHighlighted];
    [[SCActionSheet shareManager].contV addSubview:firBtn];
    
    // Bottom UIButton
    UIButton *secBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [secBtn setTag:1];
    [secBtn.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [secBtn setTitle:bottomTitle forState:UIControlStateNormal];
    [secBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [secBtn addTarget:[SCActionSheet shareManager] action:@selector(threeRowBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [secBtn setBackgroundColor:[UIColor whiteColor]];
    [secBtn setBackgroundImage:[self createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [secBtn setBackgroundImage:[self createImageWithColor:btnBgColor] forState:UIControlStateHighlighted];
    [[SCActionSheet shareManager].contV addSubview:secBtn];
    
    // Cancle UIButton
    UIButton *thirdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [thirdBtn setTag:2];
    [thirdBtn.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [thirdBtn setTitle:@"取消" forState:UIControlStateNormal];
    [thirdBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [thirdBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [thirdBtn addTarget:[SCActionSheet shareManager] action:@selector(threeRowBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [thirdBtn setBackgroundColor:[UIColor whiteColor]];
    [thirdBtn setBackgroundImage:[self createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [thirdBtn setBackgroundImage:[self createImageWithColor:btnBgColor] forState:UIControlStateHighlighted];
    [[SCActionSheet shareManager].contV addSubview:thirdBtn];
    
    // 约束
    [firBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo([SCActionSheet shareManager].contV.mas_top).with.offset(0);
        make.left.equalTo([SCActionSheet shareManager].contV.mas_left).with.offset(0);
        make.right.equalTo([SCActionSheet shareManager].contV.mas_right).with.offset(0);
        make.height.equalTo(secBtn.mas_height);
    }];
    
    [secBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firBtn.mas_bottom).with.offset(0.5);
        make.left.equalTo([SCActionSheet shareManager].contV.mas_left).with.offset(0);
        make.right.equalTo([SCActionSheet shareManager].contV.mas_right).with.offset(0);
        make.height.equalTo(thirdBtn.mas_height);
    }];
    
    [thirdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(secBtn.mas_bottom).with.offset(6);
        make.left.equalTo([SCActionSheet shareManager].contV.mas_left).with.offset(0);
        make.right.equalTo([SCActionSheet shareManager].contV.mas_right).with.offset(0);
        make.bottom.equalTo([SCActionSheet shareManager].contV.mas_bottom);
        make.height.equalTo(secBtn.mas_height);
    }];
    
    
    
    [UIView animateWithDuration:0.5 delay:0.2 usingSpringWithDamping:0.8 initialSpringVelocity:0.5 options:UIViewAnimationOptionTransitionCurlUp animations:^{
        [[SCActionSheet shareManager].contV setFrame:CGRectMake(0, KMAINSCREEN_HEIGHT - KCONTENTVIEW_HEIGHT_THIRDROWS, KMAINSCREEN_WIDTH, KCONTENTVIEW_HEIGHT_THIRDROWS)];
    } completion:^(BOOL finished) {
    }];
    
}



- (void)actionSheetWithTopTitle:(NSString *)topTitle
                    middleTitle:(NSString *)middleTitle
                    bottomTitle:(NSString *)bottomTitle
               topBtnClickBlock:(SCTopBtnBlock)topBtnClickBlock
               middleClickBlock:(SCMiddleBtnBlock)middleClickBlock
            bottomBtnClickBlock:(SCBottomBtnBlock)bottomBtnClickBlock {
    
    _topBtnBlock = topBtnClickBlock;
    _middleBtnBlock = middleClickBlock;
    _bottomBtnBlock = bottomBtnClickBlock;
    [[SCActionSheet shareManager] setHidden:NO];
    
    // 添加ContentView
    UIView *contV = [[UIView alloc] initWithFrame:CGRectMake(0, KMAINSCREEN_HEIGHT, KMAINSCREEN_WIDTH, KCONTENTVIEW_HEIGHT_FOURTHROWS)];
    UIColor *color = [UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.0];
    [contV setBackgroundColor:color];
    [[SCActionSheet shareManager] addSubview:contV];
    [SCActionSheet shareManager].contV = contV;
    
    
    UIColor *btnBgColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1.0];
    // Top UIButton
    UIButton *topBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [topBtn setTag:0];
    [topBtn.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [topBtn setTitle:topTitle forState:UIControlStateNormal];
    [topBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [topBtn addTarget:[SCActionSheet shareManager] action:@selector(fourRowBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [topBtn setBackgroundColor:[UIColor whiteColor]];
    [topBtn setBackgroundImage:[self createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [topBtn setBackgroundImage:[self createImageWithColor:btnBgColor] forState:UIControlStateHighlighted];
    [[SCActionSheet shareManager].contV addSubview:topBtn];
    
    // Middle UIButton
    UIButton *middleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [middleBtn setTag:1];
    [middleBtn.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [middleBtn setTitle:middleTitle forState:UIControlStateNormal];
    [middleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [middleBtn addTarget:[SCActionSheet shareManager] action:@selector(fourRowBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [middleBtn setBackgroundColor:[UIColor whiteColor]];
    [middleBtn setBackgroundImage:[self createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [middleBtn setBackgroundImage:[self createImageWithColor:btnBgColor] forState:UIControlStateHighlighted];
    [[SCActionSheet shareManager].contV addSubview:middleBtn];
    
    // Bottom UIButton
    UIButton *bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomBtn setTag:2];
    [bottomBtn.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [bottomBtn setTitle:bottomTitle forState:UIControlStateNormal];
    [bottomBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [bottomBtn addTarget:[SCActionSheet shareManager] action:@selector(fourRowBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomBtn setBackgroundColor:[UIColor whiteColor]];
    [bottomBtn setBackgroundImage:[self createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [bottomBtn setBackgroundImage:[self createImageWithColor:btnBgColor] forState:UIControlStateHighlighted];
    [[SCActionSheet shareManager].contV addSubview:bottomBtn];
    
    // Cancle UIButton
    UIButton *thirdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [thirdBtn setTag:3];
    [thirdBtn.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [thirdBtn setTitle:@"取消" forState:UIControlStateNormal];
    [thirdBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [thirdBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [thirdBtn addTarget:[SCActionSheet shareManager] action:@selector(fourRowBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [thirdBtn setBackgroundColor:[UIColor whiteColor]];
    [thirdBtn setBackgroundImage:[self createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [thirdBtn setBackgroundImage:[self createImageWithColor:btnBgColor] forState:UIControlStateHighlighted];
    [[SCActionSheet shareManager].contV addSubview:thirdBtn];
    
    // 约束
    [topBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo([SCActionSheet shareManager].contV.mas_top).with.offset(0);
        make.left.equalTo([SCActionSheet shareManager].contV.mas_left).with.offset(0);
        make.right.equalTo([SCActionSheet shareManager].contV.mas_right).with.offset(0);
        make.height.equalTo(middleBtn.mas_height);
    }];
    
    [middleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topBtn.mas_bottom).with.offset(0.5);
        make.left.equalTo([SCActionSheet shareManager].contV.mas_left).with.offset(0);
        make.right.equalTo([SCActionSheet shareManager].contV.mas_right).with.offset(0);
        make.height.equalTo(bottomBtn.mas_height);
    }];
    
    [bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(middleBtn.mas_bottom).with.offset(0.5);
        make.left.equalTo([SCActionSheet shareManager].contV.mas_left).with.offset(0);
        make.right.equalTo([SCActionSheet shareManager].contV.mas_right).with.offset(0);
        make.height.equalTo(thirdBtn.mas_height);
    }];
    
    [thirdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomBtn.mas_bottom).with.offset(6);
        make.left.equalTo([SCActionSheet shareManager].contV.mas_left).with.offset(0);
        make.right.equalTo([SCActionSheet shareManager].contV.mas_right).with.offset(0);
        make.bottom.equalTo([SCActionSheet shareManager].contV.mas_bottom);
        make.height.equalTo(bottomBtn.mas_height);
    }];
    
    
    
    [UIView animateWithDuration:0.5 delay:0.2 usingSpringWithDamping:0.8 initialSpringVelocity:0.5 options:UIViewAnimationOptionTransitionCurlUp animations:^{
        [[SCActionSheet shareManager].contV setFrame:CGRectMake(0, KMAINSCREEN_HEIGHT - KCONTENTVIEW_HEIGHT_FOURTHROWS, KMAINSCREEN_WIDTH, KCONTENTVIEW_HEIGHT_FOURTHROWS)];
    } completion:^(BOOL finished) {
    }];
}



#pragma mark - Button Action

- (void)twoRowBtnClick:(UIButton *)btn {
    
    switch (btn.tag) {
        case 0: // 顶部按钮
        {
            if (self.topBtnBlock) {
                self.topBtnBlock();
            }
            [self tapWindow];
            break;
        }
        case 1: // 取消按钮
        {
            [self tapWindow];
            break;
        }
            
        default:
            break;
    }
}

- (void)fourRowBtnClick:(UIButton *)btn {
    
    switch (btn.tag) {
        case 0: // 顶部按钮
        {
            if (self.topBtnBlock) {
                self.topBtnBlock();
            }
            [self tapWindow];
            break;
        }
        case 1: // 中间按钮
        {
            if (self.middleBtnBlock) {
                self.middleBtnBlock();
            }
            [self tapWindow];
            break;
        }
        case 2: // 底部按钮
        {
            if (self.bottomBtnBlock) {
                self.bottomBtnBlock();
            }
            [self tapWindow];
            break;
        }

        case 3: // 取消按钮
        {
            [self tapWindow];
            break;
        }
        default:
            break;
    }
}


- (void)threeRowBtnClick:(UIButton *)btn {
    
    switch (btn.tag) {
        case 0: // 顶部按钮
        {
            if (self.topBtnBlock) {
                self.topBtnBlock();
            }
            [self tapWindow];
            break;
        }
        case 1: // 底部按钮
        {
            if (self.bottomBtnBlock) {
                self.bottomBtnBlock();
            }
            [self tapWindow];
            break;
        }
        case 2: // 取消按钮
        {
            [self tapWindow];
            break;
        }
            
        default:
            break;
    }
}


- (void)dismiss {
    [[SCActionSheet shareManager].contV removeFromSuperview];
    [SCActionSheet shareManager].contV = nil;
    [SCActionSheet shareManager].hidden = YES;
}


- (void)tapWindow {
    
    [UIView animateWithDuration:0.3 animations:^{
        [[SCActionSheet shareManager].contV setFrame:CGRectMake(0, KMAINSCREEN_HEIGHT, KMAINSCREEN_WIDTH, KCONTENTVIEW_HEIGHT_THIRDROWS)];
    } completion:^(BOOL finished) {
        [[SCActionSheet shareManager] dismiss];
    }];
}


// 颜色转UIImage
- (UIImage*) createImageWithColor:(UIColor*) color {
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


@end
