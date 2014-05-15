//
//  AuthorViewController.m
//  WHNewsReader
//
//  Created by Caroline Godwin on 5/13/14.
//
//

#import "WHAuthorViewController.h"
#import "WHAuthorObject.h"

@interface WHAuthorViewController ()
@property (weak, nonatomic) IBOutlet UILabel *authorName;
@property (weak, nonatomic) IBOutlet UIImageView *authorImage;
@property (weak, nonatomic) IBOutlet UILabel *authorPosition;
@property (weak, nonatomic) IBOutlet UILabel *authorEmail;
@property (weak, nonatomic) IBOutlet UILabel *authorUsername;

@end

@implementation WHAuthorViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    WHAuthorObject *author = [[WHAuthorObject alloc] init];
   
    _authorName.text = author.firstName, @" ", author.lastName;
    _authorPosition.text = author.position;
    _authorEmail.text = author.email;
    _authorUsername.text = author.username;
    
    
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
