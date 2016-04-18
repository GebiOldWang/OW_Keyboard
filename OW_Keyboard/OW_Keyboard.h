//
//  OWKeyboard.h
//  OWKeyboard
//
//  Created by 上海银来（集团）有限公司 on 15/11/29.
//  Copyright © 2015年 Old.Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OW_Keyboard : UIView
/**
 *  数组控制
 */
@property (nonatomic,copy) void (^numberKeyboardInput)(NSInteger number);
/**
 *  返回控制
 */
@property (nonatomic,copy) void (^numberKeyboardBackspace)();
/**
 *  小数点
 */
@property (nonatomic,copy) void (^numberKeyboardDian)(NSString * string);
/**
 *  点击完成
 */
@property (nonatomic,copy) void (^completeBlock)();
/**
 *   初始化方法
 */
+(instancetype)ow_keyboard;

@end
