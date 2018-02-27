//
//  UIViewController+CLTransition.m
//  CLTransitionLib
//
//  Created by ClaudeLi on 2018/2/27.
//  Copyright © 2018年 ClaudeLi. All rights reserved.
//

#import "UIViewController+CLTransition.h"
#import <objc/runtime.h>
#import "UIViewController+CLTransitionObject.h"
#import "CLPercentDrivenInteractiveTransition.h"

UINavigationControllerOperation _operation;
CLPercentDrivenInteractiveTransition *_interactive;
CLTransitionManager *_transtion;

@implementation UIViewController (CLTransition)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Method method0 = class_getInstanceMethod(self.class, @selector(cl_dismissViewControllerAnimated:completion:));
        Method method1 = class_getInstanceMethod(self.class, @selector(dismissViewControllerAnimated:completion:));
        method_exchangeImplementations(method0, method1);
        
        SEL originalSelector = @selector(viewDidAppear:);
        SEL swizzledSelector = @selector(cl_viewDidAppear:);
        
        Method originalMethod = class_getInstanceMethod(self.class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(self.class, swizzledSelector);
        
        BOOL success = class_addMethod(self.class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (success) {
            class_replaceMethod(self.class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
        
        originalSelector = @selector(viewWillDisappear:);
        swizzledSelector = @selector(cl_viewWillDisappear:);
        
        originalMethod = class_getInstanceMethod(self.class, originalSelector);
        swizzledMethod = class_getInstanceMethod(self.class, swizzledSelector);
        
        success = class_addMethod(self.class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (success) {
            class_replaceMethod(self.class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
        
    });
}

- (void)cl_dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
    if (self.cl_delegateFlag) {
        self.transitioningDelegate = self;
        if (self.cl_transitioningDelegate) {
            self.transitioningDelegate = self.cl_transitioningDelegate;
        }
    }
    [self cl_dismissViewControllerAnimated:flag completion:completion];
}

- (void)cl_viewDidAppear:(BOOL)animated {
    [self cl_viewDidAppear:animated];
}


- (void)cl_viewWillDisappear:(BOOL)animated {
    [self cl_viewWillDisappear:animated];
}

#pragma mark Action Method
- (void)presentViewController:(UIViewController *)viewControllerToPresent completion:(void (^)(void))completion{
    [self presentViewController:viewControllerToPresent makeTransition:nil completion:completion];
}

- (void)presentViewController:(UIViewController *)viewControllerToPresent animationType:(CLTransitionAnimationType)animationType completion:(void (^)(void))completion{
    [self presentViewController:viewControllerToPresent makeTransition:^(CLTransitionObject *transition) {
        transition.animationType = animationType;
    } completion:completion];
}

- (void)presentViewController:(UIViewController *)viewControllerToPresent makeTransition:(CLTransitionBlock)transitionBlock{
    [self presentViewController:viewControllerToPresent makeTransition:transitionBlock completion:nil];
}

- (void)presentViewController:(UIViewController *)viewControllerToPresent makeTransition:(CLTransitionBlock)transitionBlock completion:(void (^)(void))completion{
    if (viewControllerToPresent.transitioningDelegate) {
        self.cl_transitioningDelegate = viewControllerToPresent.transitioningDelegate;
    }
    viewControllerToPresent.cl_addTransitionFlag = YES;
    viewControllerToPresent.transitioningDelegate = viewControllerToPresent;
    viewControllerToPresent.cl_callBackTransition = transitionBlock ? transitionBlock : nil;
    [self presentViewController:viewControllerToPresent animated:YES completion:completion];
}

#pragma mark Delegate
// ********************** Present Dismiss **********************
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    if (!self.cl_addTransitionFlag) {
        return nil;//dimiss directly
    }
    
    !_transtion ? _transtion = [[CLTransitionManager alloc] init] : nil ;
    CLTransitionObject *make = [[CLTransitionObject alloc] init];
    self.cl_callBackTransition ? self.cl_callBackTransition(make) : nil;
    _transtion = [CLTransitionManager copyPropertyFromObjcet:make toObjcet:_transtion];
    _transtion.transitionType = CLTransitionTypeDismiss;
    self.cl_enableBackGesture =  make.enableBackGesture;
    return _transtion;
    
}
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    if (!self.cl_addTransitionFlag) {
        return nil;//present directly
    }
    
    !_transtion ? _transtion = [[CLTransitionManager alloc] init] : nil ;
    CLTransitionObject *make = [[CLTransitionObject alloc] init];
    self.cl_callBackTransition ? self.cl_callBackTransition(make) : nil;
    _transtion = [CLTransitionManager copyPropertyFromObjcet:make toObjcet:_transtion];
    _transtion.transitionType = CLTransitionTypePresent;
    self.cl_enableBackGesture =  make.enableBackGesture;
    return _transtion;
    
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator{
    return nil;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator{
    if (!self.cl_addTransitionFlag) {
        return nil;
    }
    return _interactive.isInteractive ? _interactive : nil ;
}


//  ********************** Push Pop **********************
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    
    if (!self.cl_addTransitionFlag) {
        return nil;
    }
    !_transtion ? _transtion = [[CLTransitionManager alloc] init] : nil ;
    CLTransitionObject *make = [[CLTransitionObject alloc] init];
    self.cl_callBackTransition ? self.cl_callBackTransition(make) : nil;
    _transtion = [CLTransitionManager copyPropertyFromObjcet:make toObjcet:_transtion];
    _operation = operation;
    
    
    if ( operation == UINavigationControllerOperationPush ) {
        self.cl_delegateFlag = _transtion.isSysBackAnimation ? NO : YES;
        _transtion.transitionType = CLTransitionTypePush;
    }else{
        _transtion.transitionType = CLTransitionTypePop;
    }
    
    if (_operation == UINavigationControllerOperationPush && _transtion.isSysBackAnimation == NO && _transtion.enableBackGesture) {
        //add gestrue for pop
        !_interactive ? _interactive = [[CLPercentDrivenInteractiveTransition alloc] init] : nil;
        [_interactive addGestureToViewController:self];
        _interactive.transitionType = CLTransitionTypePop;
        _interactive.getstureType = _transtion.backGestureType != CLGestureTypeNone ? _transtion.backGestureType : CLGestureTypePanRight;
        _interactive.willEndInteractiveBlock = ^(BOOL suceess) {
            _transtion.willEndInteractiveBlock ? _transtion.willEndInteractiveBlock(suceess) : nil;
        };
    }
    self.cl_enableBackGesture =  make.enableBackGesture;
    return _transtion;
    
}
- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
    
    if (!self.cl_addTransitionFlag) {
        return nil;
    }
    !_interactive ? _interactive = [[CLPercentDrivenInteractiveTransition alloc] init] : nil;
    
    if (_operation == UINavigationControllerOperationPush) {
        return nil;
    }else{
        return _interactive.isInteractive ? _interactive : nil ;
    }
    
}

@end
