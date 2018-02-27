//
//  CLTransitionManager+ViewMove.m
//  CLTransitionLib
//
//  Created by ClaudeLi on 2018/2/27.
//  Copyright © 2018年 ClaudeLi. All rights reserved.
//

#import "CLTransitionManager+ViewMove.h"

@implementation CLTransitionManager (ViewMove)

- (void)viewMoveRollNextWithType:(CLTransitionAnimationType )type andContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *startView = [self.startView snapshotViewAfterScreenUpdates:NO];
    UIView *containerView = [transitionContext containerView];
    
    [containerView addSubview:toVC.view];
    [containerView addSubview:startView];
    
    startView.frame = [self.startView convertRect:self.startView.bounds toView: containerView];
    toVC.view.alpha = 0;
    self.startView.hidden = YES;
    self.targetView.hidden = YES;
    fromVC.view.alpha = 1;
}

- (void)viewMoveNextWithType:(CLTransitionAnimationType )type andContext:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *startView = [self.startView snapshotViewAfterScreenUpdates:NO];
    UIView *containerView = [transitionContext containerView];
    
    [containerView addSubview:toVC.view];
    [containerView addSubview:startView];
    
    startView.frame = [self.startView convertRect:self.startView.bounds toView: containerView];
    toVC.view.alpha = 0;
    self.startView.hidden = YES;
    self.targetView.hidden = YES;
    fromVC.view.alpha = 1;
    
    __weak typeof(self) weakSelf = self;
    
    
    void(^AnimationBlock)(void) = ^(){
        startView.frame = [weakSelf.targetView convertRect:weakSelf.targetView.bounds toView:containerView];
        toVC.view.alpha = 1;
        fromVC.view.alpha = 0.0;
    };
    
    void(^AnimationCompletion)(void) = ^(void){
        startView.hidden = YES;
        weakSelf.startView.hidden = NO;
        weakSelf.targetView.hidden = NO;
        fromVC.view.alpha = 1;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    };
    
    if (type == CLTransitionAnimationTypeViewMoveElastic) {
        [UIView animateWithDuration:self.animationTime delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:1 / 0.7 options:UIViewAnimationOptionCurveLinear animations:^{
            AnimationBlock();
        } completion:^(BOOL finished) {
            AnimationCompletion();
        }];
    }else {
        [UIView animateWithDuration:self.animationTime animations:^{
            AnimationBlock();
        } completion:^(BOOL finished) {
            AnimationCompletion();
        }];
    }
}

- (void)viewMoveBackWithType:(CLTransitionAnimationType )type andContext:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    UIView *tempView = containerView.subviews.lastObject;
    [containerView insertSubview:toVC.view atIndex:0];
    //Default values
    self.targetView.hidden = YES;
    self.startView.hidden = YES;
    tempView.hidden = NO;
    toVC.view.hidden = NO;
    toVC.view.alpha = 1;
    fromVC.view.alpha = 1;
    tempView.frame = [self.targetView convertRect:self.targetView.bounds toView:fromVC.view];
    __weak typeof(self) weakSelf = self;
    void(^AnimationBlock)(void) = ^(){
        tempView.frame = [weakSelf.startView convertRect:weakSelf.startView.bounds toView:containerView];
        fromVC.view.alpha = 0;
        toVC.view.alpha = 1;
    };
    
    void(^AnimationCompletion)(void) = ^(void){
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        if ([transitionContext transitionWasCancelled]) {
            tempView.hidden = YES;
            weakSelf.targetView.hidden = NO;
            weakSelf.startView.hidden = NO;
        }else{
            weakSelf.startView.hidden = NO;
            weakSelf.targetView.hidden = YES;
            toVC.view.hidden = NO;
            [tempView removeFromSuperview];
        }
        fromVC.view.hidden = NO;
    };
    
    if (type == CLTransitionAnimationTypeViewMoveElastic) {
        [UIView animateWithDuration:self.animationTime delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:1 / 0.7 options:UIViewAnimationOptionCurveLinear animations:^{
            AnimationBlock();
        } completion:^(BOOL finished) {
            AnimationCompletion();
        }];
    }else {
        [UIView animateWithDuration:self.animationTime animations:^{
            AnimationBlock();
        } completion:^(BOOL finished) {
            AnimationCompletion();
        }];
    }
    __weak UIViewController * weakFromVC = fromVC;
    self.willEndInteractiveBlock  = ^(BOOL success){
        if (success) {
            weakFromVC.view.hidden = YES;
            weakSelf.startView.hidden = NO;
            weakSelf.targetView.hidden = YES;
            [tempView removeFromSuperview];
        }else{
            tempView.hidden = YES;
            weakSelf.startView.hidden = NO;
            weakSelf.targetView.hidden = NO;
        }
    };
    
}

@end