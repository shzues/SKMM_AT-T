//
//  DetailViewController.m
//  ShoutOutPromo
//
//  Created by DanS on 9/7/13.
//
//

#import "DetailViewController.h"

#import "CommentViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize cdPromoID;

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
    
    //myScroll_banner.
    CGSize scrollableSizeMenu = CGSizeMake(self.myScroll.frame.size.width, self.myScroll.frame.size.height + 500);
    [self.myScroll setContentSize:scrollableSizeMenu];
    
    
    
    
    
    
    //Left
    UISwipeGestureRecognizer *oneFingerSwipeUp =
    [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(oneFingerSwipeLeft:)];
    [oneFingerSwipeUp setDirection:UISwipeGestureRecognizerDirectionRight];
    [[self view] addGestureRecognizer:oneFingerSwipeUp];
    
}



- (void)oneFingerSwipeLeft:(UISwipeGestureRecognizer *)recognizer
{
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)action_goBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)viewDidUnload {
    [self setMyTableContent:nil];
    [self setMyScroll:nil];
    [self setVw_panel_notif:nil];
    [self setLbl_title:nil];
    [self setLbl_content:nil];
    [super viewDidUnload];
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
    
    
    myTimer = [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(action_open_notif) userInfo:nil repeats:YES];
    
    
    
    
    //From
    self.vw_panel_notif.frame = CGRectMake(0, -100, self.vw_panel_notif.frame.size.width, self.vw_panel_notif.frame.size.height);
    
    
    
    
    if ([cdPromoID isEqualToString:@"0"]) {
        self.lbl_title.text = @"50% Discount on Sandwich Meals.";
        self.lbl_content.text = @"Pickle & Fig";
    }else if ([cdPromoID isEqualToString:@"1"]) {
        self.lbl_title.text = @"30% Discount on Latte Drinks.";
        self.lbl_content.text = @"Coffee Sociate";
    }else if ([cdPromoID isEqualToString:@"2"]) {
        self.lbl_title.text = @"FREE Hot Latte when you purchase a slice of cake.";
        self.lbl_content.text = @"Espresso Lab";
    }else if ([cdPromoID isEqualToString:@"3"]) {
        self.lbl_title.text = @"20% Discount on Swimwear.";
        self.lbl_content.text = @"Sports World";
    }else if ([cdPromoID isEqualToString:@"4"]) {
        self.lbl_title.text = @"40% Storewide Discount.";
        self.lbl_content.text = @"Mango";
    }else if ([cdPromoID isEqualToString:@"5"]) {
        self.lbl_title.text = @"20% Discount Women Apparels";
        self.lbl_content.text = @"Marks & Spencer";
    }else if ([cdPromoID isEqualToString:@"6"]) {
        self.lbl_title.text = @"30% Discount on House Burgers";
        self.lbl_content.text = @"Burger Lab";
    }else if ([cdPromoID isEqualToString:@"7"]) {
        self.lbl_title.text = @"FREE Spaghetti when you spend over Rm30.";
        self.lbl_content.text = @"Delicious";
    }else if ([cdPromoID isEqualToString:@"8"]) {
        self.lbl_title.text = @"50% Discount on Chef Nasi Lemak";
        self.lbl_content.text = @"Nasi Lemak Antarabangsa";
    }else{
        self.lbl_title.text = @"50% Discount on Sandwich Meals.";
        self.lbl_content.text = @"Pickle & Fig";
    }
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    
    UILabel *titleLabelV1 = (UILabel *)[cell viewWithTag:1001];
    
    if (indexPath.row == 0) {
        titleLabelV1.text = @"The Sandwiches is delicious";
    }else if (indexPath.row == 1) {
        titleLabelV1.text = @"Worth trying";
    }else if (indexPath.row == 2) {
        titleLabelV1.text = @"i luv their coffee art";
    }else if (indexPath.row == 2) {
        titleLabelV1.text = @"wish i could rush over for the promotion on time";
    }else{
        titleLabelV1.text = [NSString stringWithFormat:@"Comment %d", indexPath.row];
    }
    
    
    
    
    
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // Deselect
    [self.myTableContent deselectRowAtIndexPath:indexPath animated:YES];
    
    
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    
    
    
}


- (IBAction)action_goComment:(id)sender {
    
    CommentViewController *rvController = [self.storyboard instantiateViewControllerWithIdentifier:@"CommentView"];
    [self.navigationController pushViewController:rvController animated:YES];
}


- (void)action_stopTimer{
    
    [myTimer invalidate];
    myTimer = nil;
}

- (void)action_stopTimer_close{
    
    [myTimerClose invalidate];
    myTimerClose = nil;
}



- (void)viewWillDisappear:(BOOL)animated {
	
	[super viewWillDisappear:animated];
    
    [self action_stopTimer];
    
    [self action_stopTimer_close];
}

-(void)action_open_notif {
    
    //From
    self.vw_panel_notif.frame = CGRectMake(0, -100, self.vw_panel_notif.frame.size.width, self.vw_panel_notif.frame.size.height);
    
    
    //To
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.vw_panel_notif.frame = CGRectMake(0, 0, self.vw_panel_notif.frame.size.width, self.vw_panel_notif.frame.size.height);
                     }
                     completion:nil];
    
    
    
    [self action_stopTimer];
    myTimerClose = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(action_close_notif) userInfo:nil repeats:YES];
    
    
}



-(void)action_close_notif {
    
    //From
    self.vw_panel_notif.frame = CGRectMake(0, 0, self.vw_panel_notif.frame.size.width, self.vw_panel_notif.frame.size.height);
    
    
    //To
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.vw_panel_notif.frame = CGRectMake(0, -100, self.vw_panel_notif.frame.size.width, self.vw_panel_notif.frame.size.height);
                     }
                     completion:nil];
    
    
    [self action_stopTimer_close];
    myTimer = [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(action_open_notif) userInfo:nil repeats:YES];
    
    
}

- (IBAction)action_endKeyboard:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)action_search:(id)sender {
}


@end
