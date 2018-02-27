//
//  UINavigationController+CLTransition.h
//  CLTransitionLib
//
//  Created by ClaudeLi on 2018/2/27.
//  Copyright © 2018年 ClaudeLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLTransitionConfig.h"
#import "UIViewController+CLTransition.h"

@interface UINavigationController (CLTransition)

- (void)pushViewController:(UIViewController *)viewController animationType:(CLTransitionAnimationType) animationType;
- (void)pushViewController:(UIViewController *)viewController makeTransition:(CLTransitionBlock) transitionBlock;

@end
