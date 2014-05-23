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
@property (assign,readwrite) IBOutlet CGPoint center;

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
    WHAuthorObject *author = _selectedAuthor;
    self.title = @"Washington Herald";
    
    
    NSURL *url = [NSURL URLWithString:author.imageUrl];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc] initWithData:data];
    
    _authorName.text = [NSString stringWithFormat:@"%@ %@", author.firstName, author.lastName]  ;
  
    UIImageView *imageView = [[UIImageView alloc] initWithImage:img];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.frame = CGRectMake(0,0,150,150);
//    [self.view addSubview:imageView];

    _authorImage.image = img;
    UIView *profilepic = [[UIView alloc]initWithFrame:imageView.frame];
    [profilepic addSubview:imageView];
    profilepic.layer.cornerRadius = profilepic.frame.size.height /2;
    
    profilepic.layer.masksToBounds = YES;
    profilepic.layer.borderWidth = 0;
    CGRect frame = profilepic.frame;
    frame.origin.x = ((self.view.frame.size.width)/2) - 75;
    frame.origin.y = 100;
    profilepic.frame = frame;
    [self.view addSubview:profilepic];
    
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
