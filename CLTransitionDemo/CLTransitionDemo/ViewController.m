//
//  ViewController.m
//  CLTransitionDemo
//
//  Created by ClaudeLi on 2018/2/27.
//  Copyright © 2018年 ClaudeLi. All rights reserved.
//

#import "ViewController.h"
#import <CLTransitionLib/CLTransitionLib.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 使用
//    [self.navigationController pushViewController:weakDetail makeTransition:^(CLTransitionObject *transition) {
//        transition.animationType = CLTransitionAnimationTypeViewMoveElastic;
//        transition.animationTime = 0.6;
//        transition.startView  = cell.whiteView;
//        transition.targetView = weakDetail.topView;
//    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
