//
//  WHStoryViewController.m
//  WHNewsReader
////
////  Created by Caroline Godwin on 5/13/14.
////
////
//
//#import "WHStoryViewController.h"
//#import "WHAuthorObject.h"
//
//@interface WHStoryViewController ()
//@property (weak, nonatomic) IBOutlet UILabel *storyBody;
//@property (weak, nonatomic) IBOutlet UIImageView *storyImage;
//@property (weak, nonatomic) IBOutlet UILabel *storyTitle;
//@property (weak, nonatomic) IBOutlet UILabel *storySubtitle;
//@property (weak, nonatomic) IBOutlet UIView *authorMiniView;
//@property (weak, nonatomic) IBOutlet UIImageView *authorMiniImage;
//@property (weak, nonatomic) IBOutlet UILabel *authorName;
//@property (weak, nonatomic) IBOutlet UILabel *authorPosition;
//@property (weak, nonatomic) IBOutlet UIButton *authorInfo;
//@property (weak, nonatomic) IBOutlet UILabel *storyDate;
//@property (weak, nonatomic) IBOutlet UIImageView *navImage;
//@property (weak, nonatomic) IBOutlet UIButton *navImageButton;
//
//
//@end
//
//@implementation WHStoryViewController
//
//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    // Do any additional setup after loading the view from its nib.
//    WHStoryObject *story = _selectedStory;
//    _storyTitle.text = story.title;
//    _storySubtitle.text = story.subtitle;
//    _storyBody.text = story.body;
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
//    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
//    _storyDate.text = [dateFormatter stringFromDate:story.datePublished];
//    _storyImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:story.imageUrl]]];
//    
//    [_navImageButton addTarget:self action:@selector(didTapMyButton:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_navImage];
//    [self.view addSubview:_navImageButton];
//    
//
//
//
//    
//    WHAuthorObject *author = [[WHAuthorObject alloc] init];
//     _authorMiniImage.image = [NSURL URLWithString:author.imageUrl];
//      _authorName.text = [NSString stringWithFormat:@"%@ %@", author.firstName, author.lastName]  ;
//    _authorPosition.text = author.position;
//    
//}
//
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//-(void)didTapMyButton:(UIButton *)sender{
////    [sender setTitle:@"Did Tap Button" forState:UIControlStateNormal];
////    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://www.github.com/carolinegodwin"]];
//
////Create alert
//       UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Story Location" message:@"My Message" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
//    //    //Show Alert
//        [alert show];
//    
//}
//
//@end
//
//  WHStoryViewController.m
//  WHNewsReader
//
//  Created by Caroline Godwin on 5/13/14.
//
//

#import "WHStoryViewController.h"
#import "WHAuthorObject.h"
#import "WHAuthorViewController.h"
#import "WHDataRetrieval.h"
#import "NSObject+ObjectMap.h"

@interface WHStoryViewController ()
@property (weak, nonatomic) IBOutlet UILabel *storyBody;
@property (weak, nonatomic) IBOutlet UIImageView *storyImage;
@property (weak, nonatomic) IBOutlet UILabel *storyTitle;
@property (weak, nonatomic) IBOutlet UILabel *storySubtitle;
@property (weak, nonatomic) IBOutlet UIView *authorMiniView;
@property (weak, nonatomic) IBOutlet UIImageView *authorMiniImage;
@property (weak, nonatomic) IBOutlet UILabel *authorName;
@property (weak, nonatomic) IBOutlet UILabel *authorPosition;
@property (weak, nonatomic) IBOutlet UIButton *authorInfo;
@property (weak, nonatomic) IBOutlet UILabel *storyDate;
@property WHAuthorObject *author;


@end

@implementation WHStoryViewController


- (IBAction)authorButtonPressed:(id)sender {
    
    WHAuthorViewController *authorVC = [[WHAuthorViewController alloc] init];
    authorVC.selectedAuthor = _author;
    [self.navigationController pushViewController:authorVC animated:YES];
}

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
    [WHDataRetrieval setUserToken:@"b7a2ac80-67a7-41bb-a7ff-8e6574b0bdf2"];
    [WHDataRetrieval getStoryById:_selectedStory.storyId userToken:[WHDataRetrieval userToken] completetionHandler:
     ^(NSURLResponse *response, NSData *data, NSError *error){
         
//         _items = [NSObject arrayOfType:[WHStoryObject class] FromJSONData:data];
         _selectedStory = [[WHStoryObject alloc] initWithJSONData:data];
         
         
         dispatch_async(dispatch_get_main_queue(), ^{
             WHStoryObject *story = _selectedStory;
             self.title = story.title;
             _storyTitle.backgroundColor = [UIColor whiteColor];
             _storySubtitle.backgroundColor = [UIColor whiteColor];
             _storyBody.backgroundColor = [UIColor whiteColor];
             _storyTitle.text = story.title;
             _storySubtitle.text = story.subtitle;
             _storyBody.text = story.body;
             NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
             
             [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
             [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
             _storyDate.text = [dateFormatter stringFromDate:story.datePublished];
             _storyImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:story.imageUrl]]];
             

             //WHAuthorObject *author = [[WHAuthorObject alloc] init];
             //_authorMiniImage.image = [NSURL URLWithString:author.imageUrl];
             
             _author = [[WHAuthorObject alloc] init];
             _author.firstName = story.author.firstName;
             _author.lastName = story.author.lastName;
             _author.position = story.author.position;
             _author.imageUrl = story.author.imageUrl;
             _author.email = story.author.email;
             
             NSURL *url = [NSURL URLWithString:_author.imageUrl];
             NSData *data = [NSData dataWithContentsOfURL:url];
             UIImage *img = [[UIImage alloc] initWithData:data];
             
             _authorMiniImage.image = img;
             
             
             _authorName.backgroundColor = [UIColor whiteColor];
             _authorPosition.backgroundColor = [UIColor whiteColor];
             _authorName.text = [NSString stringWithFormat:@"%@ %@", _author.firstName, _author.lastName];
             _authorPosition.text = _author.position;
             
             }
             
         );
         
     }];
  
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end