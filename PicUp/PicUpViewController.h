//
//  PicUpViewController.h
//  PicUp
//
//  Created by Sam Davies on 20/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PicUpViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    UIImageView *imageView;
    UIButton    *takePhotoButton;
    UIButton    *choosePhotoButton;
}

@property (nonatomic, retain) IBOutlet UIImageView * imageView;
@property (nonatomic, retain) IBOutlet UIButton * takePhotoButton;
@property (nonatomic, retain) IBOutlet UIButton * choosePhotoButton;

-(IBAction) getPhoto:(id) sender;

@end