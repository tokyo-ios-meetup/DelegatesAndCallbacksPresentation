//
//  UIImagePicker+Block.m
//  DelegateAndCallbacks
//
//  Created by Matt on 3/13/15.
//  Copyright (c) 2015 Matt. All rights reserved.
//

#import "UIImagePicker+Block.h"
#import <objc/runtime.h>

@implementation UIImagePickerController(Block)

@dynamic completionHandler;

- (void)setCompletionHandler:(void(^)(UIImage *))object {
  objc_setAssociatedObject(self, @selector(completionHandler), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void(^)(UIImage *))completionHandler {
  return objc_getAssociatedObject(self, @selector(completionHandler));
}

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
