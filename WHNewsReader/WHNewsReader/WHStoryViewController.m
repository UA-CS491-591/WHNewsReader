//
//  WHStoryViewController.m
//  WHNewsReader
//
//  Created by Caroline Godwin on 5/13/14.
//
//

#import "WHStoryViewController.h"
#import "WHStoryObject.h"
#import "WHAuthorObject.h"

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


@end

@implementation WHStoryViewController

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
    WHStoryObject *story = _selectedStory;
    _storyTitle.text = story.title;
    _storySubtitle.text = story.subtitle;
    _storyBody.text = story.body;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    _storyDate.text = [dateFormatter stringFromDate:story.datePublished];
    _storyImage.image = [NSURL URLWithString:story.imageUrl];
    

    

    
    WHAuthorObject *author = [[WHAuthorObject alloc] init];
     _authorMiniImage.image = [NSURL URLWithString:author.imageUrl];
      _authorName.text = [NSString stringWithFormat:@"%@ %@", author.firstName, author.lastName]  ;
    _authorPosition.text = author.position;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
