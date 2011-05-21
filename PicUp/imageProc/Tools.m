//
//  Tools.m
//  PicUp
//
//  Created by Sam Davies on 21/05/2011.
//  Copyright 2011 VisualPutty. All rights reserved.
//

#import "Tools.h"


@implementation UIImage (Tools)

-(UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize
{
    UIImage *srcImage       = self;
    UIImage *newImage       = nil;
    CGSize imageSize        = srcImage.size;
    CGFloat width           = imageSize.width;
    CGFloat height          = imageSize.height;
    CGFloat targetWidth     = targetSize.width;
    CGFloat targetHeight    = targetSize.height;
    CGFloat scaleFactor     = 0.0;
    CGFloat scaledWidth     = targetWidth;
    CGFloat scaledHeight    = targetHeight;
    CGPoint thumbnailPoint  = CGPointMake(0.0, 0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor  = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor;
        else
            scaleFactor = heightFactor;
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // Center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        } else if (widthFactor < heightFactor)
        {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(targetSize);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [srcImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if (newImage == nil) {
        NSLog(@"Could not scale image");
    }
    
    UIGraphicsEndImageContext();
    return newImage;
}

@end
