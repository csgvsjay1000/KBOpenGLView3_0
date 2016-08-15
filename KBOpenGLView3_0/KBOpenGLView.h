//
//  KBOpenGLView.h
//  KBOpenGLView3_0
//
//  Created by chengshenggen on 6/22/16.
//  Copyright © 2016 Gan Tian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface KBOpenGLView : UIView

@property(nonatomic,strong) CMAttitude *referenceAttitude;
@property(nonatomic,strong) CMMotionManager *motionManager;

-(GLuint)rendImage:(UIImage *)image;

- (void)newFrameReadyAtTime:(GLuint)texture;

-(void)refreshFrame;

@end
