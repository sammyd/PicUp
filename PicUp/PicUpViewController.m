//
//  PicUpViewController.m
//  PicUp
//
//  Created by Sam Davies on 20/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PicUpViewController.h"

@implementation PicUpViewController
@synthesize imageView, choosePhotoButton, takePhotoButton;

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)getPhoto:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    if ((UIButton*) sender == choosePhotoButton) {
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    } else {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    
    [self presentModalViewController:picker animated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissModalViewControllerAnimated:YES];
    imageView.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
}


- (void) uploadPhoto:(id)sender {
    NSURL *url = [NSURL URLWithString:@"http://ADDRESS_HERE"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setDelegate:self];
    [request setPostValue:@"SECRETPASS" forKey:@"key"];
    [request setData:imageView.image withFileName:@"photo.jpg" andContentType:@"image/jpeg" forKey:@"photo"];
    [request startAsynchronous];
}

- (void) requestFinished:(ASIHTTPRequest *) request {
    NSString *responseString = [request responseString];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
}


@end
