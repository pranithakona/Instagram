//
//  SettingsViewController.m
//  Instagram
//
//  Created by Pranitha Reddy Kona on 7/8/21.
//

#import "SettingsViewController.h"
#import <Parse/PFImageView.h>

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet PFImageView *photoView;
@property (weak, nonatomic) IBOutlet UITextField *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *bioLabel;


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
    self.user.image = [self getPFFileFromImage:self.photoView.image];
    
    [self.user saveInBackground];
    [self dismissViewControllerAnimated:true completion:nil];
}

- (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
 
    // check if image is not nil
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    
    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
