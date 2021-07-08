//
//  UserViewController.h
//  Instagram
//
//  Created by Pranitha Reddy Kona on 7/7/21.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserViewController : UIViewController

@property (strong, nonatomic) User *user;

@end

NS_ASSUME_NONNULL_END
