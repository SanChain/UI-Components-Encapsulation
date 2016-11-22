//
//  SCActionSheet.h
//  UI组件_定制UIActionSheet
//
//  Created by ZengSanchain on 2016/11/7.
//  Copyright © 2016年 ziFei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SCTopBtnBlock)();
typedef void(^SCMiddleBtnBlock)();
typedef void(^SCBottomBtnBlock)();


@interface SCActionSheet : UIWindow
@property (copy, nonatomic) SCTopBtnBlock topBtnBlock; /**< 顶部 */
@property (copy, nonatomic) SCMiddleBtnBlock middleBtnBlock; /**< 中间按钮 */
@property (copy, nonatomic) SCBottomBtnBlock bottomBtnBlock; /**< 底下按钮 */

+ (instancetype)shareManager;

/**
 *  两行按钮
 */
- (void)actionSheetWithTopTitle:(NSString *)topTitle
               topBtnClickBlock:(SCTopBtnBlock)topBtnClickBlock;

/**
 *  3行按钮
 */
- (void)actionSheetWithTopTitle:(NSString *)topTitle
                    bottomTitle:(NSString *)bottomTitle
               topBtnClickBlock:(SCTopBtnBlock)topBtnClickBlock
            bottomBtnClickBlock:(SCBottomBtnBlock)bottomBtnClickBlock;

/**
 *  4行按钮
 */
- (void)actionSheetWithTopTitle:(NSString *)topTitle
                    middleTitle:(NSString *)middleTitle
                    bottomTitle:(NSString *)bottomTitle
               topBtnClickBlock:(SCTopBtnBlock)topBtnClickBlock
               middleClickBlock:(SCMiddleBtnBlock)middleClickBlock
            bottomBtnClickBlock:(SCBottomBtnBlock)bottomBtnClickBlock;

@end
