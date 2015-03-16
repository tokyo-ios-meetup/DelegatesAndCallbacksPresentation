//
//  ImagePickerWrapper.h
//  DelegateAndCallbacks
//
//  Created by Matt on 3/13/15.
//  Copyright (c) 2015 Matt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImagePickerWrapper : NSObject<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (strong, nonatomic) void (^completionHandler)(UIImage *);

+ (id<NSObject>)picker:(UIImagePickerController*)picker completion:(void (^)(UIImage *))completionHandler;
- (id<NSObject>)picker:(UIImagePickerController*)picker completion:(void (^)(UIImage *))completionHandler;

@end
