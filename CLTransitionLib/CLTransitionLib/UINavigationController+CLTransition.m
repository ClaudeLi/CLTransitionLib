//
//  UINavigationController+CLTransition.m
//  CLTransitionLib
//
//  Created by ClaudeLi on 2018/2/27.
//  Copyright © 2018年 ClaudeLi. All rights reserved.
//

#import "UINavigationController+CLTransition.h"
#import <objc/runtime.h>
#import "UIViewController+CLTransitionObject.h"

@implementation UINavigationController (CLTransition)

#pragma mark Hook
+(void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Method method0 = class_getInstanceMethod(self.class, @selector(popViewControllerAnimated:));
        Method method1 = class_getInstanceMethod(self.class, @selector(cl_popViewControllerAnimated:));
        method_exchangeImplementations(method0, method1);
        
    });
}
#pragma mark Action Method
- (void)pushViewController:(UIViewController *)viewController {
    [self pushViewController:viewController makeTransition:nil];
}

- (void)pushViewController:(UIViewController *)viewController animationType:(CLTransitionAnimationType) animationType{
    [self pushViewController:viewController makeTransition:^(CLTransitionObject *transition) {
        transition.animationType = animationType;
    }];
}

- (void)pushViewController:(UIViewController *)viewController makeTransition:(CLTransitionBlock) transitionBlock {
    if (self.delegate) {
        viewController.cl_tempNavDelegate = self.delegate;
    }
    self.delegate = viewController;
    viewController.cl_addTransitionFlag = YES;
    viewController.cl_callBackTransition = transitionBlock ? transitionBlock : nil;
    
    [self pushViewController:viewController animated:YES];
    self.delegate = nil;
    if (viewController.cl_tempNavDelegate) {
        self.delegate = viewController.cl_tempNavDelegate;
    }
}

- (UIViewController *)cl_popViewControllerAnimated:(BOOL)animated {
    if (self.viewControllers.lastObject.cl_delegateFlag) {
        self.delegate = self.viewControllers.lastObject;
        if (self.cl_tempNavDelegate) {
            self.delegate = self.cl_tempNavDelegate;
        }
    }
    return [self cl_popViewControllerAnimated:animated];
    
}

@end
