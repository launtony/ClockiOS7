//
//  MOViewController.h
//  DigitClock
//
//  Created by minsOne on 2014. 3. 20..
//  Copyright (c) 2014년 minsOne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClockViewController.h"
#import "MOSettingViewController.h"


@interface MOViewController: ClockViewController<MOSettingViewControllerDelegate>

- (void)changeBackground;

@end
