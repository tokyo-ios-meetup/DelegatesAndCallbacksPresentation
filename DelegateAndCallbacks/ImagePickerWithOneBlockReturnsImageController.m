//
//  ImagePickerWithOneBlockReturnsImageController.m
//  DelegateAndCallbacks
//
//  Created by Matt on 3/13/15.
//  Copyright (c) 2015 Matt. All rights reserved.
//

#import "ImagePickerWithOneBlockReturnsImageController.h"

@interface ImagePickerWithOneBlockReturnsImageController()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (strong, nonatomic) void (^completionHandler)(UIImage *);

@end

@implementation ImagePickerWithOneBlockReturnsImageController

- (void)pickImage:(void (^)(UIImage *))completionHandler {
  self.delegate = self;
  self.completionHandler = completionHandler;
}

- (void)imagePickerController:(UIImagePickerController *)picker
 didFinishPickingMediaWithInfo:(NSDictionary *)info {
  UIImage *image = info[UIImagePickerControllerOriginalImage];
  self.completionHandler(image);
  self.completionHandler = nil;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
  self.completionHandler(nil);
  self.completionHandler = nil;
}

- (void)dealloc {
  NSLog(@"Dealloc: %@", self.description);
}

@end
