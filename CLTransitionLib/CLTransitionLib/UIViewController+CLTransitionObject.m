//
//  UIViewController+CLTransitionObject.m
//  CLTransitionLib
//
//  Created by ClaudeLi on 2018/2/27.
//  Copyright © 2018年 ClaudeLi. All rights reserved.
//

#import "UIViewController+CLTransitionObject.h"
#import <objc/runtime.h>

static NSString *cl_callBackTransitionKey   = @"cl_callBackTransitionKey";
static NSString *cl_delegateFlagKey         = @"cl_delegateFlagKey";
static NSString *cl_addTransitionFlagKey    = @"cl_addTransitionFlagKey";
static NSString *cl_enableBackGestureKey    = @"cl_enableBackGestureKey";
static NSString *cl_transitioningDelegateKey = @"cl_transitioningDelegateKey";
static NSString *cl_tempNavDelegateKey      = @"cl_tempNavDelegateKey";


@implementation UIViewController (CLTransitionObject)

//----- cl_callBackTransition
- (void)setCl_callBackTransition:(CLTransitionBlock)cl_callBackTransition{
    objc_setAssociatedObject(self, &cl_callBackTransitionKey, cl_callBackTransition, OBJC_ASSOCIATION_COPY);
}
- (CLTransitionBlock)cl_callBackTransition{
    return objc_getAssociatedObject(self, &cl_callBackTransitionKey);
}

//----- cl_delegateFlag
- (void)setCl_delegateFlag:(BOOL)cl_delegateFlag{
    objc_setAssociatedObject(self, &cl_delegateFlagKey, @(cl_delegateFlag), OBJC_ASSOCIATION_ASSIGN);
}
-(BOOL)cl_delegateFlag {
    return [objc_getAssociatedObject(self, &cl_delegateFlagKey) integerValue] == 0 ?  NO : YES;
}

//----- cl_addTransitionFlag
- (void)setCl_addTransitionFlag:(BOOL)cl_addTransitionFlag{
    objc_setAssociatedObject(self, &cl_addTransitionFlagKey, @(cl_addTransitionFlag), OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)cl_addTransitionFlag{
    return [objc_getAssociatedObject(self, &cl_addTransitionFlagKey) integerValue] == 0 ?  NO : YES;
}

//----- cl_enableBackGesture
- (void)setCl_enableBackGesture:(BOOL)cl_enableBackGesture{
    objc_setAssociatedObject(self, &cl_enableBackGestureKey, @(cl_enableBackGesture), OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)cl_enableBackGesture{
    return [objc_getAssociatedObject(self, &cl_enableBackGestureKey) integerValue] == 0 ?  NO : YES;
}

//----- cl_transitioningDelega
- (void)setCl_transitioningDelegate:(id)cl_transitioningDelegate {
    objc_setAssociatedObject(self, &cl_transitioningDelegateKey, cl_transitioningDelegate, OBJC_ASSOCIATION_ASSIGN);
}
- (id)cl_transitioningDelegate {
    return objc_getAssociatedObject(self, &cl_transitioningDelegateKey);
}

//----- cl_tempNavDelegate
- (void)setCl_tempNavDelegate:(id)cl_tempNavDelegate {
    objc_setAssociatedObject(self, &cl_tempNavDelegateKey, cl_tempNavDelegate, OBJC_ASSOCIATION_ASSIGN);
}
- (id)cl_tempNavDelegate {
    return objc_getAssociatedObject(self, &cl_tempNavDelegateKey);
}

@end
