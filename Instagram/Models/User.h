//
//  User.h
//  Instagram
//
//  Created by Pranitha Reddy Kona on 7/8/21.
//

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : PFObject <PFSubclassing>

@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) PFUser *user;

@property (nonatomic, strong) NSString *bio;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) PFFileObject *image;

+ (void) createUser: (PFUser *) user withImage:( UIImage * _Nullable )image withName: ( NSString * _Nullable )name withBio: ( NSString * _Nullable )bio withCompletion: (PFBooleanResultBlock  _Nullable)completion;

@end

NS_ASSUME_NONNULL_END
