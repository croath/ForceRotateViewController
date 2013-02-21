//
//  ForceRotateViewController.m
//  ForceRotateExample
//
//  Created by croath on 13-2-21.
//  Copyright (c) 2013年 croath. All rights reserved.
//

#import "ForceRotateViewController.h"
#import "CoreMotion/CoreMotion.h"

@interface ForceRotateViewController (){
  CMMotionManager *_motionManager;
  UIInterfaceOrientation dOrientation, lastOrientation;
}

@end

@implementation ForceRotateViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  _motionManager = [[CMMotionManager alloc] init];
  [self checkOrientation];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
  
}

- (void)checkOrientation{
  if (!_motionManager.accelerometerAvailable) {
    return;
  } else if (![_motionManager isAccelerometerActive]){
    _motionManager.accelerometerUpdateInterval = 0.3;
    [_motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
      float x = -accelerometerData.acceleration.x;
      float y = accelerometerData.acceleration.y;
      float angle = atan2(y, x);
      
      if(angle >= -2.25 && angle <= -0.75) {
        dOrientation = UIInterfaceOrientationPortrait;
      } else if(angle >= -0.75 && angle <= 0.75){
        dOrientation = UIInterfaceOrientationLandscapeRight;
      } else if(angle >= 0.75 && angle <= 2.25) {
        dOrientation = UIInterfaceOrientationPortraitUpsideDown;
      } else if(angle <= -2.25 || angle >= 2.25) {
        dOrientation = UIInterfaceOrientationLandscapeLeft;
      }
      
      if (lastOrientation != dOrientation) {
        [self transformFromOrientation:dOrientation toOrientation:lastOrientation];
        lastOrientation = dOrientation;
      }
    }];
  }
}

- (void)transformFromOrientation:(UIInterfaceOrientation)fromO toOrientation:(UIInterfaceOrientation)toO{
  NSLog(@"%@ %d %d", NSStringFromSelector(_cmd), fromO, toO);
}


@end
