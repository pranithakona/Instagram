//
//  SettingsViewController.m
//  Instagram
//
//  Created by Pranitha Reddy Kona on 7/8/21.
//

#import "SettingsViewController.h"
#import <Parse/PFImageView.h>

@interface SettingsViewController () <UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet PFImageView *photoView;
@property (weak, nonatomic) IBOutlet UITextField *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *bioLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.photoView.layer.cornerRadius = self.photoView.bounds.size.width/2;
    self.nameLabel.text = self.user.name;
    self.bioLabel.text = self.user.bio;
    if (self.user.image){
        self.photoView.file = self.user.image;
        [self.photoView loadInBackground];
    }
    else {
        self.photoView.image = [UIImage systemImageNamed:@"person.circle"];
    }
}

- (IBAction)doDismiss:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)doUpdateUser:(id)sender {
    self.user.name = self.nameLabel.text;
    self.user.bio = self.bioLabel.text;
    UIImage *newImage = [self resizeImage:self.photoView.image withSize:CGSizeMake(200,200)];
    self.user.image = [self getPFFileFromImage:newImage];
    
    [self.activityIndicator startAnimating];
    [self.user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        [self.activityIndicator stopAnimating];
        [self dismissViewControllerAnimated:true completion:nil];
    }];
}

- (PFFileObject *)getPFFileFromImage:(UIImage * _Nullable)image {
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    if (!imageData) {
        return nil;
    }
    
    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (IBAction)doChangePhoto:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];

    self.photoView.image = originalImage;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
