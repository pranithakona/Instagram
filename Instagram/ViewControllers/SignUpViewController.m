//
//  SignUpViewController.m
//  Instagram
//
//  Created by Pranitha Reddy Kona on 7/6/21.
//

#import "SignUpViewController.h"
#import "User.h"
#import <Parse/Parse.h>

@interface SignUpViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *signupButton;

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.signupButton.layer.cornerRadius = 5;
    [self.usernameField becomeFirstResponder];
}

- (IBAction)dismissKeyboard:(id)sender {
    [self.usernameField endEditing:true];
    [self.passwordField endEditing:true];
    [self.emailField endEditing:true];
}

- (IBAction)onSignup:(id)sender {
    PFUser *newUser = [PFUser user];

    newUser.username = self.usernameField.text;
    newUser.email = self.emailField.text;
    newUser.password = self.passwordField.text;
   
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSLog(@"User registered successfully");
            [User createUser:[PFUser currentUser] withImage:[UIImage systemImageNamed:@"person.circle"] withName:[PFUser currentUser].username withBio:nil withCompletion:nil];
            [self performSegueWithIdentifier:@"signupSegue" sender:nil];
        }
    }];
}

@end
