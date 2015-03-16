//
//  ImagePickerWrapper.h
//  DelegateAndCallbacks
//
//  Created by Matt on 3/13/15.
//  Copyright (c) 2015 Matt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImagePickerWrapperSingleton.h"

static ImagePickerWrapperSingleton *sharedSingleton;

@implementation ImagePickerWrapperSingleton

+ (void)initialize {
  static BOOL initialized = NO;

  if(!initialized) {
    initialized = YES;
    sharedSingleton = [[self alloc] init];
  }
}

+ (id<NSObject>)picker:(UIImagePickerController*)picker completion:(void (^)(UIImage *))completionHandler {
  return [sharedSingleton picker:picker completion:completionHandler];
}

@end
