//
//  ProfileCell.h
//  Instagram
//
//  Created by Pranitha Reddy Kona on 7/7/21.
//

#import <UIKit/UIKit.h>
#import <Parse/PFImageView.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProfileCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet PFImageView *photoView;


@end

NS_ASSUME_NONNULL_END
