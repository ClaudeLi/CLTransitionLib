//
//  CLPercentDrivenInteractiveTransition.h
//  CLTransitionLib
//
//  Created by ClaudeLi on 2018/2/27.
//  Copyright © 2018年 ClaudeLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLTransitionConfig.h"

typedef void(^PanActionBlock)(void);

@interface CLPercentDrivenInteractiveTransition : UIPercentDrivenInteractiveTransition

@property (nonatomic, assign) CLGestureType getstureType;
@property (readonly, assign, nonatomic) BOOL isInteractive;
@property (nonatomic, assign) CLTransitionType transitionType;

@property (nonatomic, copy) PanActionBlock presentBlock;
@property (nonatomic, copy) PanActionBlock pushBlock;
@property (nonatomic, copy) PanActionBlock dismissBlock;
@property (nonatomic, copy) PanActionBlock popBlock;

@property (nonatomic, copy) void(^willEndInteractiveBlock)(BOOL success);

-(void)addGestureToViewController:(UIViewController *)vc;

@end
