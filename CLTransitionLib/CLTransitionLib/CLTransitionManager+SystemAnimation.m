//
//  CLTransitionManager+SystemAnimation.m
//  CLTransitionLib
//
//  Created by ClaudeLi on 2018/2/27.
//  Copyright © 2018年 ClaudeLi. All rights reserved.
//

#import "CLTransitionManager+SystemAnimation.h"

@implementation CLTransitionManager (SystemAnimation)

-(void)sysTransitionNextAnimationWithTransition:(CATransition *)transition context:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *tempView = [toVC.view snapshotViewAfterScreenUpdates:YES];
    UIView *temView1 = [fromVC.view snapshotViewAfterScreenUpdates:YES];
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:fromVC.view];
    [containerView addSubview:toVC.view];
    [containerView bringSubviewToFront:fromVC.view];
    [containerView bringSubviewToFront:toVC.view];
    if (!transition) {
        transition=[CATransition animation];
        transition.duration= self.animationTime;
        transition.delegate = self;
        transition.type = kCATransitionFade;
    }
    [containerView.layer addAnimation:transition forKey:nil];
    self.completionBlock = ^(){
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:NO];
        }else{
            [transitionContext completeTransition:YES];
            toVC.view.hidden = NO;
        }
        [tempView removeFromSuperview];
        [temView1 removeFromSuperview];
        
    };
}

-(void)sysTransitionBackAnimationWithTransition:(CATransition *)transition context:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *tempView = [toVC.view snapshotViewAfterScreenUpdates:YES];
    UIView *temView1 = [fromVC.view snapshotViewAfterScreenUpdates:YES];
    UIView *containerView = [transitionContext containerView];
    
    [containerView addSubview:fromVC.view];
    [containerView addSubview:toVC.view];
    
    if (!transition) {
        transition=[CATransition animation];
        transition.duration= self.animationTime;
        transition.delegate = self;
        transition.type = kCATransitionFade;
    }
    [containerView.layer addAnimation:transition forKey:nil];
    
    __weak UIViewController * weakToVC = toVC;
    self.completionBlock = ^(){
        
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:NO];
        }else{
            [transitionContext completeTransition:YES];
        }
        weakToVC.view.hidden = NO;
        
        [tempView removeFromSuperview];
        [temView1 removeFromSuperview];
    };
    self.willEndInteractiveBlock = ^(BOOL success) {
        if (success) {
            weakToVC.view.hidden = NO;
        }else{
            weakToVC.view.hidden = YES;
            [tempView removeFromSuperview];
            [temView1 removeFromSuperview];
        }
        
    };
}

@end
