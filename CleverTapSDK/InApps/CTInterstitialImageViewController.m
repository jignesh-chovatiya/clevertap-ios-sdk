#import "CTInterstitialImageViewController.h"
#import "CTInAppDisplayViewControllerPrivate.h"
#import "CTDismissButton.h"

@interface CTInterstitialImageViewController ()

@property (nonatomic, strong) IBOutlet UIView *containerView;
@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) IBOutlet CTDismissButton *closeButton;

@end

@implementation CTInterstitialImageViewController

- (instancetype)initWithNotification:(CTInAppNotification *)notification {
    self = [super initWithNibName:[CTInAppUtils XibNameForControllerName:NSStringFromClass([CTInterstitialImageViewController class])] bundle:[CTInAppUtils bundle]];
    if (self) {
        self.notification = notification;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    [self layoutNotification];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup Notification

- (void)layoutNotification {
    
    // UIView container which holds all other subviews
    self.containerView.backgroundColor = [CTInAppUtils ct_colorWithHexString:self.notification.backgroundColor];
    
    self.closeButton.hidden = !self.notification.showCloseButton;
    
    if ([UIScreen mainScreen].bounds.size.height == 480) {
        [self.containerView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [[NSLayoutConstraint constraintWithItem:self.containerView
                                      attribute:NSLayoutAttributeWidth
                                      relatedBy:NSLayoutRelationEqual
                                         toItem:self.containerView
                                      attribute:NSLayoutAttributeHeight
                                     multiplier:0.6 constant:0] setActive:YES];
        
    }
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [self.containerView setTranslatesAutoresizingMaskIntoConstraints:NO];
        if (self.notification.tablet) {
            [[NSLayoutConstraint constraintWithItem:self.containerView
                                          attribute:NSLayoutAttributeLeading
                                          relatedBy:NSLayoutRelationEqual
                                             toItem:self.view attribute:NSLayoutAttributeLeading
                                         multiplier:1 constant:40] setActive:YES];
            [[NSLayoutConstraint constraintWithItem:self.containerView
                                          attribute:NSLayoutAttributeTrailing
                                          relatedBy:NSLayoutRelationEqual
                                             toItem:self.view attribute:NSLayoutAttributeTrailing
                                         multiplier:1 constant:-40] setActive:YES];
            [[NSLayoutConstraint constraintWithItem:self.containerView
                                          attribute:NSLayoutAttributeHeight
                                          relatedBy:NSLayoutRelationEqual
                                             toItem:self.view
                                          attribute:NSLayoutAttributeHeight
                                         multiplier:0.85 constant:0] setActive:YES];
            
        }else {
            [[NSLayoutConstraint constraintWithItem:self.containerView
                                          attribute:NSLayoutAttributeLeading
                                          relatedBy:NSLayoutRelationEqual
                                             toItem:self.view attribute:NSLayoutAttributeLeading
                                         multiplier:1 constant:160] setActive:YES];
            [[NSLayoutConstraint constraintWithItem:self.containerView
                                          attribute:NSLayoutAttributeTrailing
                                          relatedBy:NSLayoutRelationEqual
                                             toItem:self.view attribute:NSLayoutAttributeTrailing
                                         multiplier:1 constant:-160] setActive:YES];
            
        }
    }

    // set image
    if (self.notification.image) {
        self.imageView.clipsToBounds = YES;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.image = [UIImage imageWithData:self.notification.image];
        self.imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *imageTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleImageTapGesture:)];
        [self.imageView addGestureRecognizer:imageTapGesture];
    }
}

#pragma mark - Actions

- (IBAction)closeButtonTapped:(id)sender {
    [super tappedDismiss];
}

- (void)handleImageTapGesture:(UITapGestureRecognizer *)sender {
    [self handleImageTapGesture];
    [self hide:true];
}

#pragma mark - Public

-(void)show:(BOOL)animated {
    [self showFromWindow:animated];
}

-(void)hide:(BOOL)animated {
    [self hideFromWindow:animated];
}

@end
