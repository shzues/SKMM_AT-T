//
//  MainMenuViewController.m
//  ShoutOutMerchant
//
//  Created by DanS on 9/8/13.
//
//

#import "MainMenuViewController.h"

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController

@synthesize cdCurTimeSlot;

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    
    //Navi Bar
    self.navigationController.navigationBarHidden = YES;
    
    
    //Full Screen - Hide Status Bar.
    //[[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:NO];
    
    /*
     //Status bar.
     [[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleBlackTranslucent];
     [self setWantsFullScreenLayout:YES];
     */
    
    
    // Disable the idle timer
    [[UIApplication sharedApplication] setIdleTimerDisabled: YES];
    
    
    
    [self resetPage];
    
    
    
}

-(void)resetPage{
    
    //myScroll_banner.
    CGSize scrollableSizeMenu = CGSizeMake(self.myScroll.frame.size.width, 692 + 200);
    [self.myScroll setContentSize:scrollableSizeMenu];
    
    
    //myScroll_banner.
    CGSize scrollableSizeMenu_time = CGSizeMake(self.myScroll_timeoption.frame.size.width, 452);
    [self.myScroll_timeoption setContentSize:scrollableSizeMenu_time];
    
    self.img_token_1.hidden = TRUE;
    self.img_token_2.hidden = TRUE;
    self.img_token_3.hidden = TRUE;
    
    self.myScroll_timeoption.hidden = TRUE;
    
    self.img_timeoption_1.hidden = TRUE;
    self.img_timeoption_2.hidden = TRUE;
    self.img_timeoption_3.hidden = TRUE;
    
    
    self.img_upload.hidden = TRUE;
    
    cdCurTimeSlot = @"";
    
    [self.btn_time_1 setImage:[UIImage imageNamed:@"pick_time.png"] forState:UIControlStateNormal];
    [self.btn_time_2 setImage:[UIImage imageNamed:@"pick_time.png"] forState:UIControlStateNormal];
    [self.btn_time_3 setImage:[UIImage imageNamed:@"pick_time.png"] forState:UIControlStateNormal];
    
    
    
    self.txt_content.text = @"";
    self.txt_coordinate.text = @"3.147702,101.714574";
    
    
    self.vw_panel_status.frame = CGRectMake(0, 480, self.vw_panel_status.frame.size.width, self.vw_panel_status.frame.size.height);
    
    
    
    
    
    //GOTO.
    CGRect frame = self.myScroll.frame;
    
    float pageNumberYouWantToGoTo = 0;
    
    frame.origin.x = frame.size.width * pageNumberYouWantToGoTo;
    frame.origin.y = 0;
    [self.myScroll scrollRectToVisible:frame animated:NO];
    
    
    [self.myScroll_timeoption scrollRectToVisible:frame animated:NO];
    
    
    
    
    
    
}

- (void)viewDidUnload {
    [self setMyScroll:nil];
    [self setTxt_content:nil];
    [self setBtn_content:nil];
    [self setImg_upload:nil];
    [self setImg_token_1:nil];
    [self setImg_token_2:nil];
    [self setImg_token_3:nil];
    [self setImg_timeoption_1:nil];
    [self setImg_timeoption_2:nil];
    [self setImg_timeoption_3:nil];
    [self setMyScroll_timeoption:nil];
    [self setBtn_time_1:nil];
    [self setBtn_time_2:nil];
    [self setBtn_time_3:nil];
    [self setTxt_coordinate:nil];
    [self setVw_panel_status:nil];
    [super viewDidUnload];
}



- (void)action_keyboard_on{
    
    self.view.frame = CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height);
    
}


- (IBAction)action_keyboard_close:(id)sender {
    
    [self.txt_content resignFirstResponder];
    
    
    
}


- (IBAction)action_time_1:(id)sender {
    
    cdCurTimeSlot = @"1";
    
    self.myScroll_timeoption.hidden = FALSE;
    
    self.img_timeoption_1.hidden = FALSE;
    self.img_timeoption_2.hidden = TRUE;
    self.img_timeoption_3.hidden = TRUE;
    
    
}

- (IBAction)action_time_2:(id)sender {
    
    cdCurTimeSlot = @"2";
    
    self.myScroll_timeoption.hidden = FALSE;
    
    self.img_timeoption_1.hidden = TRUE;
    self.img_timeoption_2.hidden = FALSE;
    self.img_timeoption_3.hidden = TRUE;
    
    
}

- (IBAction)action_time_3:(id)sender {
    
    cdCurTimeSlot = @"3";
    
    self.myScroll_timeoption.hidden = FALSE;
    
    self.img_timeoption_1.hidden = TRUE;
    self.img_timeoption_2.hidden = TRUE;
    self.img_timeoption_3.hidden = FALSE;
    
    
}


- (IBAction)action_timeoption_close:(id)sender {
    
    self.myScroll_timeoption.hidden = TRUE;
    
    if ([cdCurTimeSlot isEqualToString:@"1"]) {
        [self.btn_time_1 setImage:[UIImage imageNamed:@"8pm.png"] forState:UIControlStateNormal];
        self.img_token_1.hidden = FALSE;
    }else if ([cdCurTimeSlot isEqualToString:@"2"]) {
        [self.btn_time_2 setImage:[UIImage imageNamed:@"3pm.png"] forState:UIControlStateNormal];
        self.img_token_2.hidden = FALSE;
    }else if ([cdCurTimeSlot isEqualToString:@"3"]) {
        [self.btn_time_3 setImage:[UIImage imageNamed:@"8pm.png"] forState:UIControlStateNormal];
        self.img_token_3.hidden = FALSE;
    }
    
    
    
}

- (IBAction)action_camera:(id)sender {
    
    self.img_upload.hidden = FALSE;
    
}

- (IBAction)action_keyboard_end:(id)sender {
    
    [self.view endEditing:TRUE];
    
}

- (IBAction)action_success_close:(id)sender {
    
    //From
    self.vw_panel_status.frame = CGRectMake(0, 0, self.vw_panel_status.frame.size.width, self.vw_panel_status.frame.size.height);
    
    
    //To
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.vw_panel_status.frame = CGRectMake(0, 480, self.vw_panel_status.frame.size.width, self.vw_panel_status.frame.size.height);
                     }
                     completion:nil];
    
    //myScroll_banner.
    CGSize scrollableSizeMenu = CGSizeMake(self.myScroll.frame.size.width, 692 + 200);
    [self.myScroll setContentSize:scrollableSizeMenu];
    
    
    //myScroll_banner.
    CGSize scrollableSizeMenu_time = CGSizeMake(self.myScroll_timeoption.frame.size.width, 452);
    [self.myScroll_timeoption setContentSize:scrollableSizeMenu_time];
    
    self.img_token_1.hidden = TRUE;
    self.img_token_2.hidden = TRUE;
    self.img_token_3.hidden = TRUE;
    
    self.myScroll_timeoption.hidden = TRUE;
    
    self.img_timeoption_1.hidden = TRUE;
    self.img_timeoption_2.hidden = TRUE;
    self.img_timeoption_3.hidden = TRUE;
    
    
    self.img_upload.hidden = TRUE;
    
    cdCurTimeSlot = @"";
    
    [self.btn_time_1 setImage:[UIImage imageNamed:@"pick_time.png"] forState:UIControlStateNormal];
    [self.btn_time_2 setImage:[UIImage imageNamed:@"pick_time.png"] forState:UIControlStateNormal];
    [self.btn_time_3 setImage:[UIImage imageNamed:@"pick_time.png"] forState:UIControlStateNormal];
    
    
    
    self.txt_content.text = @"";
    self.txt_coordinate.text = @"3.147702,101.714574";
    
    
    //self.vw_panel_status.frame = CGRectMake(0, 480, self.vw_panel_status.frame.size.width, self.vw_panel_status.frame.size.height);
    
    
    
    
    
    //GOTO.
    CGRect frame = self.myScroll.frame;
    
    float pageNumberYouWantToGoTo = 0;
    
    frame.origin.x = frame.size.width * pageNumberYouWantToGoTo;
    frame.origin.y = 0;
    [self.myScroll scrollRectToVisible:frame animated:NO];
    
    
    [self.myScroll_timeoption scrollRectToVisible:frame animated:NO];
}


- (IBAction)action_success_open:(id)sender {
    
    //From
    self.vw_panel_status.frame = CGRectMake(0, 480, self.vw_panel_status.frame.size.width, self.vw_panel_status.frame.size.height);
    
    
    //To
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.vw_panel_status.frame = CGRectMake(0, 0, self.vw_panel_status.frame.size.width, self.vw_panel_status.frame.size.height);
                     }
                     completion:nil];
}



- (IBAction)action_reset:(id)sender {
    [self resetPage];
}


- (IBAction)action_submit:(id)sender {
    
    [self action_success_open:nil];
    
}



@end
