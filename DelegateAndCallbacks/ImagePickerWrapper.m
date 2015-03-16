//
//  ImagePickerWrapper.h
//  DelegateAndCallbacks
//
//  Created by Matt on 3/13/15.
//  Copyright (c) 2015 Matt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImagePickerWrapper.h"

@interface ImagePickerWrapper()
@end

@implementation ImagePickerWrapper

+ (id<NSObject>)picker:(UIImagePickerController*)picker completion:(void (^)(UIImage *))completionHandler {
  ImagePickerWrapper *wrapper = [[[self class] alloc] init];
  return [wrapper picker:picker completion:completionHandler];
}

- (id<NSObject>)picker:(UIImagePickerController*)picker completion:(void (^)(UIImage *))completionHandler {
  picker.delegate = self;
  self.completionHandler = completionHandler;
  return self;
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
