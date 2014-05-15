//
//  WHLoginView.h
//  WHNewsReader
//
//  Created by Kelly Galuska on 5/13/14.
//
//

#import <UIKit/UIKit.h>

@interface WHLoginView : UIView
@property (weak, nonatomic) IBOutlet UITextField *userNameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextfield;

//- (id)initWithFrame:(CGRect)frame login:(WHLogin *)login;
- (NSString *)getUsername;
- (NSString *)getPassword;

@end
