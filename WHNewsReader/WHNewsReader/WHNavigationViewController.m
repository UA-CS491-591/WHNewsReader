//
//  WHNavigationViewController.m
//  WHNewsReader
//
//  Created by Caroline Godwin on 5/22/14.
//  Copyright (c) 2014 Washington Herald. All rights reserved.
//

#import "WHNavigationViewController.h"


@interface WHNavigationViewController ()

@end

@implementation WHNavigationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

//-(void)viewDidAppear:(BOOL)animated
//
//{
//    {
//        NSTimeInterval delay = .1; //Try different values for delay
//        
//        //Use dispatch_after to set the center coordinate after a delay.
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC), dispatch_get_main_queue(),
//                       ^{
//                           [self.restaurantMap setCenterCoordinate:coordinate animated:YES];
//                       }
//                       );
//    
//    CLLocationCoordinate2D coordinate;
//    
//    coordinate.latitude = 49.2802;
//    
//    coordinate.longitude = -123.1182;
//    
//    [self.restaurantMap setCenterCoordinate:coordinate animated:YES];
    
//}
//     [super viewDidAppear: animated];
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
