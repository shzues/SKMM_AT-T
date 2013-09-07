//
//  CommentViewController.m
//  ShoutOutPromo
//
//  Created by DanS on 9/7/13.
//
//

#import "CommentViewController.h"

@interface CommentViewController ()

@end

@implementation CommentViewController

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
    
    
    
    
    self.vw_panel_success.hidden = TRUE;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)action_goBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewDidUnload {
    [self setTxt_comment:nil];
    [self setVw_panel_success:nil];
    [super viewDidUnload];
}
- (IBAction)action_endKeyboard:(id)sender {
    
    [sender resignFirstResponder];
    
}

- (IBAction)action_submit:(id)sender {
    
    self.vw_panel_success.hidden = FALSE;
    
}

- (IBAction)action_done:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



@end
