//
//  UIViewController+CLTransitionObject.h
//  CLTransitionLib
//
//  Created by ClaudeLi on 2018/2/27.
//  Copyright © 2018年 ClaudeLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLTransitionObject;

typedef void(^CLTransitionBlock)(CLTransitionObject *transition);

@interface UIViewController (CLTransitionObject)

@property (nonatomic, copy  ) CLTransitionBlock     cl_callBackTransition;
@property (nonatomic, assign) BOOL                  cl_delegateFlag;
@property (nonatomic, assign) BOOL                  cl_addTransitionFlag;
@property (nonatomic, assign) BOOL                  cl_enableBackGesture;

@property (nonatomic, weak  ) id                    cl_transitioningDelegate;
@property (nonatomic, weak  ) id                    cl_tempNavDelegate;


@end
