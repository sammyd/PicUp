//
//  PicUpViewController.m
//  PicUp
//
//  Created by Sam Davies on 20/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PicUpViewController.h"
#import "Tools.h"

@implementation PicUpViewController
@synthesize imageView, choosePhotoButton, takePhotoButton, uploadButton, activityIndicator;

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
    imageView.image = [(UIImage *)[info objectForKey:@"UIImagePickerControllerOriginalImage"] imageByScalingAndCroppingForSize:CGSizeMake(450.0, 600.0)];
    uploadButton.hidden = FALSE;
    [picker release];
}


- (void) uploadPhoto:(id)sender {
    NSURL *url = [NSURL URLWithString:@"http://modulo13.ath.cx/pui_iphone/upload.php"];
    NSData *imageData = UIImageJPEGRepresentation(imageView.image, 90);
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setDelegate:self];
    [request setPostValue:@"SECRETPASS" forKey:@"key"];
    [request setData:imageData withFileName:@"photo.jpg" andContentType:@"image/jpeg" forKey:@"photo"];
    [activityIndicator startAnimating];
    [request startAsynchronous];
}

- (void) requestFinished:(ASIHTTPRequest *) request {
    [activityIndicator stopAnimating];
    NSString *responseString = [request responseString];
    NSLog(@"Success: %@", responseString);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Upload successful" message:@"Photo is now available on the webApp." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert autorelease];
    [alert show];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    [activityIndicator stopAnimating];
    //NSError *error = [request error];
    NSLog(@"Failure");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Upload failed" message:@"There was a problem. I don't know what it was. Sorry." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert autorelease];
    [alert show];
}


@end
