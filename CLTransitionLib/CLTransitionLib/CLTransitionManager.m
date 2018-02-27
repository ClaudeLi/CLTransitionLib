//
//  CLTransitionManager.m
//  CLTransitionLib
//
//  Created by ClaudeLi on 2018/2/27.
//  Copyright © 2018年 ClaudeLi. All rights reserved.
//

#import "CLTransitionManager.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "CLTransitionObject.h"
#import "CLTransitionManager+SystemAnimation.h"
#import "CLTransitionManager+ViewMove.h"
#import "CLTransitionManager+InsideThenPush.h"

@interface CLTransitionManager ()

@property (nonatomic, assign) id <UIViewControllerContextTransitioning> transitionContext;

@end

@implementation CLTransitionManager

#pragma mark - Delegate
//UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return _animationTime ;
}

- (void)animationEnded:(BOOL) transitionCompleted {
    UIViewController *toVC = [_transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    if (transitionCompleted) {
        [self removeDelegate];
        if (self.autoHideTabBar) {
            toVC.tabBarController.tabBar.alpha = 0.0;
            if (toVC.tabBarController && !toVC.hidesBottomBarWhenPushed) {
                [UIView animateWithDuration:0.1 animations:^{
                    toVC.tabBarController.tabBar.alpha = 1.0;
                }];
            }
        }
    }
    if (toVC.navigationController.navigationBar && self.autoHideNavigationBar) {
        [UIView animateWithDuration:0.1 animations:^{
            toVC.navigationController.navigationBar.alpha = 1.0;
        }];
    }
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    if (fromVC.tabBarController.tabBar && !fromVC.hidesBottomBarWhenPushed && self.autoHideTabBar) {
        fromVC.tabBarController.tabBar.alpha = 0.0;
    }
    if (fromVC.navigationController.navigationBar && self.autoHideNavigationBar) {
        fromVC.navigationController.navigationBar.alpha = 0.0;
    }
    _transitionContext = transitionContext;

    switch (_transitionType) {
        case CLTransitionTypePush:
        case CLTransitionTypePresent:
            [self transitionActionAnimation:transitionContext withAnimationType:self.animationType];
            break;
        case CLTransitionTypePop:
        case CLTransitionTypeDismiss:
            [self transitionBackAnimation:transitionContext withAnimationType:self.animationType];
            break;
        default:
            break;
    }
    
}

// CAAnimationDelegate
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (flag) {
        _completionBlock ? _completionBlock() : nil;
        _completionBlock = nil;
    }
}

#pragma mark - Action
-(void)transitionActionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext withAnimationType:(CLTransitionAnimationType )animationType{
    
    if ((NSInteger)animationType <= (NSInteger)CLTransitionAnimationTypeDefault) {
        [self sysTransitionAnimationWithType:animationType  context:transitionContext];
    }
    unsigned int count = 0;
    Method *methodlist = class_copyMethodList([CLTransitionManager class], &count);
    int tag= 0;
    for (int i = 0; i < count; i++) {
        Method method = methodlist[i];
        SEL selector = method_getName(method);
        NSString *methodName = NSStringFromSelector(selector);
        if ([methodName rangeOfString:@"NextTransitionAnimation"].location != NSNotFound) {
            tag++;
            if (tag == animationType - CLTransitionAnimationTypeDefault) {
                ((void (*)(id,SEL,id<UIViewControllerContextTransitioning>,CLTransitionAnimationType))objc_msgSend)(self,selector,transitionContext,animationType);
                break;
            }
        }
    }
    free(methodlist);
    
}

-(void)transitionBackAnimation:(id<UIViewControllerContextTransitioning>)transitionContext withAnimationType:(CLTransitionAnimationType )animationType{
    
    if ((NSInteger)animationType <= (NSInteger)CLTransitionAnimationTypeDefault) {
        [self backSysTransitionAnimationWithType:_backAnimationType  context:transitionContext];
    }
    
    unsigned int count = 0;
    Method *methodlist = class_copyMethodList([CLTransitionManager class], &count);
    int tag= 0;
    for (int i = 0; i < count; i++) {
        Method method = methodlist[i];
        SEL selector = method_getName(method);
        NSString *methodName = NSStringFromSelector(selector);
        if ([methodName rangeOfString:@"BackTransitionAnimation"].location != NSNotFound) {
            tag++;
            if (tag == animationType - CLTransitionAnimationTypeDefault) {
                ((void (*)(id,SEL,id<UIViewControllerContextTransitioning>,CLTransitionAnimationType))objc_msgSend)(self,selector,transitionContext,animationType);
                break;
            }
            
        }
    }
    free(methodlist);
}

-(void)sysTransitionAnimationWithType:(CLTransitionAnimationType) type context:(id<UIViewControllerContextTransitioning>)transitionContext{
    [self sysTransitionNextAnimationWithTransition:_systemTransition  context:transitionContext];
}

-(void)backSysTransitionAnimationWithType:(CLTransitionAnimationType) type context:(id<UIViewControllerContextTransitioning>)transitionContext{
    [self sysTransitionBackAnimationWithTransition:_systemTransition context:transitionContext];
}

#pragma mark - Animations
// *********************************************************************************************
-(void)viewMoveNextTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    [self viewMoveNextWithType:CLTransitionAnimationTypeViewMoveElastic andContext:transitionContext];
}
-(void)viewMoveBackTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    [self viewMoveBackWithType:CLTransitionAnimationTypeViewMoveElastic andContext:transitionContext];
}
-(void)viewMoveNormalNextTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    [self viewMoveNextWithType:CLTransitionAnimationTypeViewMoveNormal andContext:transitionContext];
}
-(void)viewMoveNormalBackTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    [self viewMoveBackWithType:CLTransitionAnimationTypeViewMoveNormal andContext:transitionContext];
}

// *********************************************************************************************
-(void)insideThenPushNextTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    [self insideThenPushNextAnimationWithContext:transitionContext];
}
-(void)insideThenPushBackTransitionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    [self insideThenPushBackAnimationWithContext:transitionContext];
}

#pragma mark - Other
- (void)removeDelegate {
    UIViewController *fromVC = [_transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [_transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    void (^RemoveDelegateBlock)(void) = ^(){
        
        fromVC.transitioningDelegate = nil;
        fromVC.navigationController.delegate = nil;
        toVC.transitioningDelegate = nil;
        toVC.navigationController.delegate = nil;
        
    };
    switch (self.transitionType) {
        case CLTransitionTypePush:
        case CLTransitionTypePresent:{ //Next
            if (self.isSysBackAnimation) {
                RemoveDelegateBlock ? RemoveDelegateBlock() : nil;
            }
        }
            break;
        default:{ //Back
            RemoveDelegateBlock ? RemoveDelegateBlock() : nil;
        }
            break;
    }
}


-(void)setAnimationType:(CLTransitionAnimationType)animationType {
    _animationType = animationType;
}

+(CLTransitionManager *)copyPropertyFromObjcet:(id)object toObjcet:(id)targetObjcet {
    
    CLTransitionObject *propery = object;
    CLTransitionManager *transition = targetObjcet;
    
    transition.animationTime = propery.animationTime;
    transition.transitionType = propery.transitionType;
    transition.animationType = propery.animationType;
    transition.systemTransition = propery.systemTransition;
    transition.isSysBackAnimation = propery.isSysBackAnimation;
    transition.backGestureType = propery.gestureType;
    transition.enableBackGesture = propery.enableBackGesture;
    transition.autoHideNavigationBar = propery.autoHideNavigationBar;
    transition.autoHideTabBar = propery.autoHideTabBar;
    transition.startView = propery.startView;
    transition.targetView = propery.targetView;
    return transition;
}

- (UIImage *)imageFromView: (UIView *)view atFrame:(CGRect)rect{
    
    UIGraphicsBeginImageContext(view.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    UIRectClip(rect);
    [view.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  theImage;
    
}


@end
