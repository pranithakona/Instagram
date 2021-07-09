//
//  NewPostViewController.h
//  Instagram
//
//  Created by Pranitha Reddy Kona on 7/8/21.
//

#import <UIKit/UIKit.h>
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewPostViewController : UIViewController

@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) User *user;

@end

NS_ASSUME_NONNULL_END
