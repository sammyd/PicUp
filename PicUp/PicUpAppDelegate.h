//
//  PicUpAppDelegate.h
//  PicUp
//
//  Created by Sam Davies on 20/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PicUpViewController;

@interface PicUpAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet PicUpViewController *viewController;

@end
