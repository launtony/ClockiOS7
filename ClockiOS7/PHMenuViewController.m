//
//  PHMenuViewController.m
//  PHAirTransaction
//
//  Created by Ta Phuoc Hai on 1/7/14.
//  Copyright (c) 2014 Phuoc Hai. All rights reserved.
//

#import "PHMenuViewController.h"

@implementation PHMenuViewController{
    NSArray * data;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage *image=[UIImage imageNamed:@"background"];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    // Init menu data
    NSArray * session1 = [NSArray arrayWithObjects:@"phair_root",@"segue1",@"segue2", nil];
    //NSArray * session2 = [NSArray arrayWithObjects:@"segue2",@"segue3", nil];
    data = [NSArray arrayWithObjects:session1, nil];
}

#pragma mark - PHAirMenuDelegate

- (NSInteger)numberOfSession
{
    return data.count;
}

- (NSInteger)numberOfRowsInSession:(NSInteger)sesion
{
    return ((NSArray*)data[sesion]).count;
}

- (NSString*)titleForRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
            NSString *row = [NSString stringWithFormat:@"Clock"];
            return row;
        }
        else if (indexPath.row == 1){
            NSString *row = [NSString stringWithFormat:@"Settings"];
            return row;
        }
        else {
            NSString *row = [NSString stringWithFormat:@"About"];
            return row;
        }
    }
    else {
        return [NSString stringWithFormat:@"Not Found"];
    }    
}

- (NSString*)titleForHeaderAtSession:(NSInteger)session
{
    if (session == 0) {
        return [NSString stringWithFormat:@"ClockiOS7"];
    }
    else {
        return [NSString stringWithFormat:@"Not Found"];
    }
}

- (NSString*)segueForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return data[indexPath.section][indexPath.row];
}

- (UIImage*)thumbnailImageAtIndexPath:(NSIndexPath*)indexPath
{
    return nil;
}

@end
