//
//  ImagePickerWithOneBlockReturnsImageControllerReturnsImage.h
//  DelegateAndCallbacks
//
//  Created by Matt on 3/13/15.
//  Copyright (c) 2015 Matt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImagePickerController(Block)<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (strong, nonatomic) void (^completionHandler)(UIImage *);

- (void)pickImage:(void(^)(UIImage *))completionHandler;

@end
