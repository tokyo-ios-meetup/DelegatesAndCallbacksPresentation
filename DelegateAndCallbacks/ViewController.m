//
//  ViewController.m
//  DelegateAndCallbacks
//
//  Created by Matt on 3/13/15.
//  Copyright (c) 2015 Matt. All rights reserved.
//

#import "ViewController.h"
#import "ImagePickerWithTwoBlockController.h"
#import "ImagePickerWithOneBlockController.h"
#import "ImagePickerWithOneBlockReturnsImageController.h"
#import "UIImagePicker+Block.h"
#import "ImagePickerWrapper.h"
#import "ImagePickerWrapperSingleton.h"

@interface ViewController ()
@property (strong, nonatomic) id<NSObject> pickerObserver;
@end

@implementation ViewController

- (void)pickImageButtonTapped:(UIButton*)button {
//  UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
//  imagePickerController.delegate = self;

//  ImagePickerWithTwoBlockController *imagePickerController = [[ImagePickerWithTwoBlockController alloc] init];
//  [imagePickerController pickImageWithSuccess:^(UIImagePickerController *picker, NSDictionary *info) {
//    self.imageView.image = info[UIImagePickerControllerOriginalImage];
//    [self dismissViewControllerAnimated:YES completion:nil];
//  } cancel:^(UIImagePickerController *picker) {
//    [self dismissViewControllerAnimated:YES completion:nil];
//  }];
//
//
//  ImagePickerWithOneBlockController *imagePickerController = [[ImagePickerWithOneBlockController alloc] init];
//  [imagePickerController pickImage:^(UIImagePickerController *picker, NSDictionary *info) {
//    self.imageView.image = info[UIImagePickerControllerOriginalImage];
//    [self dismissViewControllerAnimated:YES completion:nil];
//  }];
////
//  ImagePickerWithOneBlockReturnsImageController *imagePickerController = [[ImagePickerWithOneBlockReturnsImageController alloc] init];
//  [imagePickerController pickImage:^(UIImage *image) {
//    self.imageView.image = image;
//    [self dismissViewControllerAnimated:YES completion:nil];
//  }];
  UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
  [imagePickerController pickImage:^(UIImage *image) {
    self.imageView.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
  }];

//
//  UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
//  self.pickerObserver = [ImagePickerWrapper picker:imagePickerController completion:^(UIImage *image) {
//    self.imageView.image = image;
//    self.pickerObserver = nil;
//    [self dismissViewControllerAnimated:YES completion:nil];
//  }];

//
//  UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
//  [ImagePickerWrapperSingleton picker:imagePickerController completion:^(UIImage *image) {
//    self.imageView.image = image;
//    [self dismissViewControllerAnimated:YES completion:nil];
//  }];

  [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)resetButtonTapped:(UIButton *)button {
  UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
  window.rootViewController = nil;
}

- (void)dealloc {
  NSLog(@"Dealloc: %@", self.description);
}

@end
