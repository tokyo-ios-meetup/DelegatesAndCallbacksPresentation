//
//  ImagePickerWithTwoBlockController.m
//  DelegateAndCallbacks
//
//  Created by Matt on 3/13/15.
//  Copyright (c) 2015 Matt. All rights reserved.
//

#import "ImagePickerWithTwoBlockController.h"

@interface ImagePickerWithTwoBlockController()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (strong, nonatomic) void (^successHandler)(UIImagePickerController*, NSDictionary*);
@property (strong, nonatomic) void (^cancelHandler)(UIImagePickerController*);

@end

@implementation ImagePickerWithTwoBlockController

- (void)pickImageWithSuccess:(void (^)(UIImagePickerController *, NSDictionary *))successHandler
 cancel:(void (^)(UIImagePickerController *))cancelHandler {
  self.delegate = self;
  self.successHandler = successHandler;
  self.cancelHandler = cancelHandler;
}

- (void)imagePickerController:(UIImagePickerController *)picker
 didFinishPickingMediaWithInfo:(NSDictionary *)info {
  self.successHandler(picker, info);
  self.successHandler = nil;
  self.cancelHandler = nil;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
  self.cancelHandler(picker);
  self.successHandler = nil;
  self.cancelHandler = nil;
}

- (void)dealloc {
  NSLog(@"Dealloc: %@", self.description);
}

@end
