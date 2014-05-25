//
//  MOViewController.m
//  DigitClock
//
//  Created by minsOne on 2014. 3. 20..
//  Copyright (c) 2014년 minsOne. All rights reserved.
//

#import "MOViewController.h"
#import "MOSettingViewController.h"
#import "MOBackgroundColor.h"

@interface MOViewController () {
    NSTimer *tickTimer;
    NSTimer *keepAliveTimer;
    
    CGPoint lastTranslation;
}

@property (nonatomic, strong) IBOutletCollection(UIView) NSArray *digitViews;

@end

@implementation MOViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self setup];
    [self onTickTimer];
    [self tick];

}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - Initialize Digit Clock
/**
 *  initial Digit Clock
 */
- (void)setup
{
    [self initBackground];
    [self changeBackground];
    [self initDigitView];

}


/**
 *  Initial TickTimer
 */
- (void)onTickTimer
{
    tickTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                             target:self
                                           selector:@selector(tick)
                                           userInfo:nil
                                            repeats:YES];

}

/**
 *  Clear TickTimer
 */
- (void)offTickTimer
{
    [tickTimer invalidate];
    tickTimer = nil;
}


/**
 *  initial DigitView
 */
- (void)initDigitView
{
    UIImage *digits = [UIImage imageNamed:@"Digits"];
    for (UIView *view in self.digitViews) {
        [view.layer setContents:(__bridge id)digits.CGImage];
        [view.layer setContentsRect:CGRectMake(0, 0, 1.0f/11.0f, 1.0)];
        [view.layer setContentsGravity:kCAGravityResizeAspect];
        [view.layer setMagnificationFilter:kCAFilterNearest];
    }
}

#pragma mark - Set Digit Clock View

/**
 *  Set Digit Number
 *
 *  @param digit Time Number
 *  @param view  showing View
 */
- (void)setDigit:(NSInteger)digit forView:(UIView *)view
{
    [view.layer setContentsRect:CGRectMake(digit * 1.0f / 11.0f, 0, 1.0f/11.0f, 1.0f)];
}

/**
 *  operating Digit Clock
 */
- (void)tick
{
    NSDate *date = [NSDate date];
    [UIView animateWithDuration:1.0 animations:^{
        [self setDigit:date.hour / 10 forView:self.digitViews[0]];
        [self setDigit:date.hour % 10 forView:self.digitViews[1]];
        [self setDigit:date.minute / 10 forView:self.digitViews[2]];
        [self setDigit:date.minute % 10 forView:self.digitViews[3]];
//        [self setDigit:date.second / 10 forView:self.digitViews[4]];
//        [self setDigit:date.second % 10 forView:self.digitViews[5]];
    }];
}
/**
 *  change View Alpha from up down gesture
 *
 *  @param translation gesture Point
 */
- (void)changeViewAlpha:(CGPoint)translation
{
    CGFloat alpha = [self.view alpha];
    
    if ( lastTranslation.y > translation.y && alpha < 1.0f ) {
        [self.view setAlpha:alpha + 0.01f];
    } else if ( lastTranslation.y < translation.y && alpha >= 0.02f ) {
        [self.view setAlpha:alpha - 0.01f];
    }
    lastTranslation = translation;
}

/**
 *  change Background
 */
- (void)changeBackground
{
    NSString *bgName = [[MOBackgroundColor sharedInstance]bgColorName];
    UIImage *bg = [UIImage imageNamed:bgName];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [self.view.layer setContents:(__bridge id)bg.CGImage];
    
    [defaults setInteger:[[MOBackgroundColor sharedInstance]bgColorIndex]  forKey:@"Theme"];
    [defaults synchronize];
}

/**
 *  initialize background
 */
- (void)initBackground
{
    NSString *bgName = [[MOBackgroundColor sharedInstance]bgColorName];
    UIImage *bg = [UIImage imageNamed:bgName];
    
    [self.view.layer setContents:(__bridge id)bg.CGImage];
}


/**
 *  prepare For Segue
 *
 *  @param segue  segue
 *  @param sender sender
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    MOSettingViewController *destViewController = [[[segue destinationViewController]viewControllers]objectAtIndex:0];
    destViewController.delegate = self;
}

/**
 *  display View Gesture
 *
 *  @param sender PanGesture Object
 */
- (IBAction)displayGestureForPanGestureRecognizer:(UIPanGestureRecognizer *)sender
{
    CGPoint translation = [sender translationInView:self.view];
    
    #define SWIPE_UP_THRESHOLD -1000.0f
    #define SWIPE_DOWN_THRESHOLD 1000.0f
    #define SWIPE_LEFT_THRESHOLD -1000.0f
    #define SWIPE_RIGHT_THRESHOLD 1000.0f
    
    // Get the translation in the view
    [sender setTranslation:CGPointZero inView:self.view];

    
    // But also, detect the swipe gesture
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        CGPoint vel = [sender velocityInView:self.view];
        
        if (vel.x < SWIPE_LEFT_THRESHOLD)
        {
            // TODO: Detected a swipe to the left
            NSLog(@"LEFT");
        }
        else if (vel.x > SWIPE_RIGHT_THRESHOLD)
        {
            // TODO: Detected a swipe to the right
            NSLog(@"RIGHT");
            [self.airViewController showAirViewFromViewController:self.navigationController complete:nil];
        }
        else if (vel.y < SWIPE_UP_THRESHOLD)
        {
            // TODO: Detected a swipe up
            NSLog(@"UP");
        }
        else if (vel.y > SWIPE_DOWN_THRESHOLD)
        {
            // TODO: Detected a swipe down
            NSLog(@"DOWN");
        }
    }

    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            lastTranslation = translation;
            break;
        case UIGestureRecognizerStateCancelled:
            break;
        case UIGestureRecognizerStateChanged:
            [self changeViewAlpha:translation];
            break;
        case UIGestureRecognizerStateEnded:
            break;
        case UIGestureRecognizerStateFailed:
            break;
        case UIGestureRecognizerStatePossible:
            break;
        default:
            break;
    }
}

@end
