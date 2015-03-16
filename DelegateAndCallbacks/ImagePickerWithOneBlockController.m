//
//  ImagePickerWithOneBlockController.m
//  DelegateAndCallbacks
//
//  Created by Matt on 3/13/15.
//  Copyright (c) 2015 Matt. All rights reserved.
//

#import "ImagePickerWithOneBlockController.h"

@interface ImagePickerWithOneBlockController() <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (strong, nonatomic) void (^completionHandler)(UIImagePickerController*, NSDictionary*);

@end

@implementation ImagePickerWithOneBlockController

- (void)pickImage:(void (^)(UIImagePickerController *, NSDictionary *))completionHandler {
  self.delegate = self;
  self.completionHandler = completionHandler;
}

- (void)imagePickerController:(UIImagePickerController *)picker
 didFinishPickingMediaWithInfo:(NSDictionary *)info {
  self.completionHandler(picker, info);
  self.completionHandler = nil;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
  self.completionHandler(picker, nil);
  self.completionHandler = nil;
}

- (void)dealloc {
  NSLog(@"Dealloc: %@", self.description);
}

@end
