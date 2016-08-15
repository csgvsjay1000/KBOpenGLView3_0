//
//  ViewController.m
//  KBOpenGLView3_0
//
//  Created by chengshenggen on 6/22/16.
//  Copyright © 2016 Gan Tian. All rights reserved.
//

#import "ViewController.h"
#import "KBOpenGLView.h"

@interface ViewController (){
    KBOpenGLView *glView;
    CADisplayLink *displayLink;
    GLuint texture;
}

@property(nonatomic,strong) CMAttitude *referenceAttitude;
@property(nonatomic,strong) CMMotionManager *motionManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkPresent)];
    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    displayLink.paused = YES;
    displayLink.frameInterval = 4;
    glView = [[KBOpenGLView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:glView];
    texture = [glView rendImage:[UIImage imageNamed:@"1234.jpg"]];
    
    [self startDeviceMotion];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscape;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    
    glView.frame = CGRectMake(0, 0, width, height);
    
    [glView refreshFrame];
    displayLink.paused = NO;
    
}

-(void)displayLinkPresent{
    [glView newFrameReadyAtTime:texture];
    
}

#pragma mark - private methods
- (void)startDeviceMotion {
    
    _motionManager = [[CMMotionManager alloc] init];
    _referenceAttitude = nil;
    _motionManager.deviceMotionUpdateInterval = 1.0 / 60.0;
    _motionManager.gyroUpdateInterval = 1.0f / 60;
    _motionManager.showsDeviceMovementDisplay = YES;
    
    [_motionManager startDeviceMotionUpdatesUsingReferenceFrame:CMAttitudeReferenceFrameXArbitraryCorrectedZVertical];
    
    _referenceAttitude = _motionManager.deviceMotion.attitude; // Maybe nil actually. reset it
    
    glView.motionManager = _motionManager;
    glView.referenceAttitude = _referenceAttitude;
    
}

-(void)stopDeviceMotion{
    [_motionManager stopDeviceMotionUpdates];
    _referenceAttitude = nil;
}


@end
