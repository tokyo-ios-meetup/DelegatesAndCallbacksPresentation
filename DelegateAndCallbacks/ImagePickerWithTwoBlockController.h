//
//  ImagePickerWithTwoBlockController.h
//  DelegateAndCallbacks
//
//  Created by Matt on 3/13/15.
//  Copyright (c) 2015 Matt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImagePickerWithTwoBlockController : UIImagePickerController
- (void)pickImageWithSuccess:(void(^)(UIImagePickerController*, NSDictionary*))successHandler
 cancel:(void(^)(UIImagePickerController*))cancelHandler;
@end
