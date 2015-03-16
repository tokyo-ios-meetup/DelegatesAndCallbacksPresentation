# Delegates and Callbacks

---

# Delegates are one of the Cocoa Core Competancies.

---

![](/Users/home/Desktop/Screen Shot 2015-03-14 at 9.45.11 AM.png)

---

```obj-c
{
  ...
  UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
  imagePickerController.delegate = self;
  [self presentViewController:imagePickerController animated:YES completion:nil];
}

// callbacks
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
  [self dismissViewControllerAnimated:YES completion:nil];
}

```
---

![title](file:///Users/home/Desktop/Screen%20Shot%202015-03-14%20at%209.47.27%20AM.png)

---

# One purpose that the delegates were used for was callbacks.

# Since iOS 4.0, blocks have been available.  Blocks are replacing delegates for this purpose.

---
# UIAlertView vs UIAlertController

```obj-c
UIAlertView *alertView = [[UIAlertView alloc]
                           initWithTitle:@"Title" 
                           message:@"Message"
                           delegate:self 
                           cancelButtonTitle:@"Cancel" 
                           otherButtonTitles:@"OK", nil];
[alertView show];

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex;

```
---
```objc
UIAlertController *alertController = [UIAlertController
  alertControllerWithTitle:alertTitle
  message:alertMessage
  preferredStyle:UIAlertControllerStyleAlert];
 UIAlertAction *cancelAction = [UIAlertAction 
    actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
    style:UIAlertActionStyleCancel
    handler:^(UIAlertAction *action) {
 }];

UIAlertAction *okAction = [UIAlertAction 
  actionWithTitle:NSLocalizedString(@"OK", @"OK action")
  style:UIAlertActionStyleDefault
  handler:^(UIAlertAction *action) {
  }];

[alertController addAction:cancelAction];
[alertController addAction:okAction];
```
---

# Some various strategies for turning older delegate-based APIs into block-based APIs.

---

```obj-c
{
  ...
  UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
  imagePickerController.delegate = self;
  [self presentViewController:imagePickerController animated:YES completion:nil];
}

// callbacks
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
  [self dismissViewControllerAnimated:YES completion:nil];
}

```
---
```objc
@interface ImagePickerWithTwoBlockController : UIImagePickerController
- (void)pickImageWithSuccess:(void(^)(UIImagePickerController*, NSDictionary*))successHandler
 cancel:(void(^)(UIImagePickerController*))cancelHandler;
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

@end
```

---

```obj-c
  ImagePickerWithTwoBlockController *imagePickerController = [[ImagePickerWithTwoBlockController alloc] init];
  [imagePickerController pickImageWithSuccess:^(UIImagePickerController *picker, NSDictionary *info) {
    self.imageView.image = info[UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:YES completion:nil];
  } cancel:^(UIImagePickerController *picker) {
    [self dismissViewControllerAnimated:YES completion:nil];
  }];
  ```
---

# AFNetworking 1.0 popularized a style with success and failure callbacks.

# Apple seems to prefer a single callback handler.

---

```obj-c
@interface ImagePickerWithOneBlockController : UIImagePickerController

@property (strong, nonatomic) void (^completionHandler)(UIImagePickerController*, NSDictionary*);
- (void)pickImage:(void(^)(UIImagePickerController*, NSDictionary*))completionHandler;

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

@end
```

---

```obj-c
  ImagePickerWithOneBlockController *imagePickerController = [[ImagePickerWithOneBlockController alloc] init];
  [imagePickerController pickImage:^(UIImagePickerController *picker, NSDictionary *info) {
    if (info != nil) {
      self.imageView.image = info[UIImagePickerControllerOriginalImage];
    };
    [self dismissViewControllerAnimated:YES completion:nil];
  }];
  ```
 
---
# What if we push more work inside the controller?
  
---
  
  ```obj-c
@interface ImagePickerWithOneBlockReturnsImageController : UIImagePickerController

@property (strong, nonatomic) void (^completionHandler)(UIImage *);
- (void)pickImage:(void(^)(UIImage *))completionHandler;

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

@end

```

---

  ```obj-c
  ImagePickerWithOneBlockReturnsImageController *imagePickerController = 
     [[ImagePickerWithOneBlockReturnsImageController alloc] init];
  [imagePickerController pickImage:^(UIImage *image) {
    if (info != nil) {
      self.imageView.image = image;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
  }];
```
---

# Can we do this to UIImagePickerController itself?

---

```obj-c
@interface UIImagePickerController(Block)

@property (strong, nonatomic) void (^completionHandler)(UIImage *);

- (void)pickImage:(void(^)(UIImage *))completionHandler;

@end

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

@end
```
---
```obj-c
  UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
  [imagePickerController pickImage:^(UIImage *image) {
    if (info != nil) {
      self.imageView.image = image;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
  }];
```
---
# Wrapper Object
---
```obj-c

@interface ImagePickerWrapper : NSObject<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (strong, nonatomic) void (^completionHandler)(UIImage *);

+ (id<NSObject>)picker:(UIImagePickerController*)picker completion:(void (^)(UIImage *))completionHandler;
- (id<NSObject>)picker:(UIImagePickerController*)picker completion:(void (^)(UIImage *))completionHandler;

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

@end

```

---

```obj-c
  UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
  self.pickerObserver = [ImagePickerWrapper picker:imagePickerController completion:^(UIImage *image) {
    self.imageView.image = image;
    self.pickerObserver = nil;
    [self dismissViewControllerAnimated:YES completion:nil];
  }];
```
---
![](/Users/home/Desktop/Screen Shot 2015-03-14 at 10.33.00 AM.png)

---
```obj-c
@interface ImagePickerWrapperSingleton : ImagePickerWrapper
@end

@implementation ImagePickerWrapperSingleton

static BOOL initialized = NO;

+ (void)initialize {  
  if(!initialized) {
    initialized = YES;
    sharedSingleton = [[self alloc] init];
  }
}

+ (id<NSObject>)picker:(UIImagePickerController*)picker completion:(void (^)(UIImage *))completionHandler {
  return [sharedSingleton picker:picker completion:completionHandler];
}

@end
```

---
```obj-c
  UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
  [ImagePickerWrapperSingleton picker:imagePickerController completion:^(UIImage *image) {
    self.imageView.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
  }];
```
---

# Why?
- Readability
- Keep variables inside the local context
- Integrating with third-party APIs (ReactiveCocoa, PromiseKit)

