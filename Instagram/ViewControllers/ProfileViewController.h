//
//  ProfileViewController.h
//  Instagram
//
//  Created by Pranitha Reddy Kona on 7/8/21.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController

@property (strong, nonatomic) User *user;
@property (strong, nonatomic) PFUser *pfUser;

@end

NS_ASSUME_NONNULL_END
