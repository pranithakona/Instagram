//
//  UserView.h
//  Instagram
//
//  Created by Pranitha Reddy Kona on 7/8/21.
//

#import <UIKit/UIKit.h>
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserView : UIView <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (strong, nonatomic) NSArray* arrayOfPosts;
@property (strong, nonatomic) User* user;

@end

NS_ASSUME_NONNULL_END
