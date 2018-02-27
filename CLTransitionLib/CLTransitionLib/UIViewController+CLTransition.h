//
//  UIViewController+CLTransition.h
//  CLTransitionLib
//
//  Created by ClaudeLi on 2018/2/27.
//  Copyright © 2018年 ClaudeLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLTransitionObject.h"
#import "CLTransitionManager.h"

typedef void(^CLTransitionBlock)(CLTransitionObject *transition);

@interface UIViewController (CLTransition)<UIViewControllerTransitioningDelegate,UINavigationControllerDelegate>

- (void)presentViewController:(UIViewController *)viewControllerToPresent animationType:(CLTransitionAnimationType)animationType completion:(void (^)(void))completion;
- (void)presentViewController:(UIViewController *)viewControllerToPresent makeTransition:(CLTransitionBlock)transitionBlock;
- (void)presentViewController:(UIViewController *)viewControllerToPresent makeTransition:(CLTransitionBlock)transitionBlock completion:(void (^)(void))completion;

@end
