//
//  User.m
//  Instagram
//
//  Created by Pranitha Reddy Kona on 7/8/21.
//

#import "User.h"

@implementation User

@dynamic userID;
@dynamic user;
@dynamic name;
@dynamic image;
@dynamic bio;

+ (nonnull NSString *)parseClassName {
    return @"Account";
}

+ (void) createUser: (PFUser *) user withImage:( UIImage * _Nullable )image withName:( NSString * _Nullable )name withBio:( NSString * _Nullable )bio withCompletion:(PFBooleanResultBlock  _Nullable)completion {
    
    User *newUser = [User new];
    newUser.image = [self getPFFileFromImage:image];
    newUser.user = [PFUser currentUser];
    newUser.bio = bio;
    newUser.name = name;
    
    [newUser saveInBackgroundWithBlock: completion];
}

+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    if (!imageData) {
        return nil;
    }
    
    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
}

@end
