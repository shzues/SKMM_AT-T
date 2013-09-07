//
//  MainMenuViewController.m
//  ShoutOutPromo
//
//  Created by DanS on 9/6/13.
//
//

#import "MainMenuViewController.h"


#import "SBJson.h"

#import "UIImageView+WebCache.h"




#import "MyLocation.h"


#import "DetailViewController.h"

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController

@synthesize btn_followUser;
@synthesize btn_goSubmit;

@synthesize cdStore_title;


@synthesize receivedData;
@synthesize results;
@synthesize dataArray;

@synthesize _loadingWindowAlert;
@synthesize _loadingPanel;
@synthesize vw_alert;
@synthesize lbl_alert;
@synthesize lbl_title;
@synthesize lbl_speedLimit;
@synthesize lbl_nearSpot;



@synthesize myMap;
@synthesize myMapSegment;
@synthesize cdStore_id;

@synthesize cdFromPage;
@synthesize cdFetching;
@synthesize cdDidUpdateUserLocation;

@synthesize startLocation;




@synthesize locationManager;


@synthesize vw_triggerBg;

@synthesize lbl_warning_distance;
@synthesize lbl_distance;
@synthesize vw_displayPanel;


@synthesize _nearLat, _nearLong;

@synthesize _followUser;


@synthesize _Setting_Display, _Setting_Sound, _Setting_Vibrate, _Setting_Value;
@synthesize _TriggeSpot;
@synthesize _nearSpot;



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
    
    
    
    myMap.delegate = self;
    myMap.showsUserLocation = YES;
    
    //Zoom.
    // 1
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = myMap.userLocation.location.coordinate.latitude;
    zoomLocation.longitude = myMap.userLocation.location.coordinate.latitude;
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 3500, 3500);
    // 3
    MKCoordinateRegion adjustedRegion = [myMap regionThatFits:viewRegion];
    // 4
    [myMap setRegion:adjustedRegion animated:YES];
    
    
    self.myMap.centerCoordinate = myMap.userLocation.location.coordinate;
    
    
    
    //Left
    UISwipeGestureRecognizer *oneFingerSwipeUp =
    [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(oneFingerSwipeLeft:)];
    [oneFingerSwipeUp setDirection:UISwipeGestureRecognizerDirectionRight];
    [[self view] addGestureRecognizer:oneFingerSwipeUp];
    
    
    
    
    //_followUser = @"false";
    
    
    
    
    
    
    
    //Button Style.
    btn_goSubmit.titleLabel.textColor = [UIColor whiteColor];
    
    UIImage *greenButtonImage = [UIImage imageNamed:@"green-button.png"];
    UIImage *stretchableGreenButton = [greenButtonImage stretchableImageWithLeftCapWidth:12 topCapHeight:0];
    [btn_goSubmit setBackgroundImage:stretchableGreenButton forState:UIControlStateNormal];
    btn_goSubmit.titleLabel.shadowColor = [UIColor blackColor];
    btn_goSubmit.titleLabel.shadowOffset = CGSizeMake(1.5, 1.5);
    
    
    UIImage *darkGreenButtonImage = [UIImage imageNamed:@"green-button-dark.png"];
    UIImage *stretchabledarkGreenButton = [darkGreenButtonImage stretchableImageWithLeftCapWidth:12 topCapHeight:0];
    [btn_goSubmit setBackgroundImage:stretchabledarkGreenButton forState:UIControlStateHighlighted];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
    
    
    
    
    //myScroll_banner.
    CGSize scrollableSizeMenu = CGSizeMake(self.myScroll.frame.size.width * 2, self.myScroll.frame.size.height);
    [self.myScroll setContentSize:scrollableSizeMenu];
    
    
    
    
    //GOTO.
    CGRect frame = self.myScroll.frame;
    
    float pageNumberYouWantToGoTo = 0;
    
    frame.origin.x = frame.size.width * pageNumberYouWantToGoTo;
    frame.origin.y = 0;
    [self.myScroll scrollRectToVisible:frame animated:YES];
    
    
    
    
    
    ////////////////////////
    
    // Disable the idle timer
    [[UIApplication sharedApplication] setIdleTimerDisabled: YES];
    
    
    myMap.delegate = self;
    myMap.showsUserLocation = YES;
    
    
    
    //clear app badge
    [UIApplication sharedApplication].applicationIconBadgeNumber=0;
    
    
    vw_triggerBg.backgroundColor = [UIColor yellowColor];
    
    
    vw_alert.hidden = YES;
    
    
    
    
    lbl_title.text = cdStore_title;
    
    
    
    
    
    //if ([cdFromPage isEqualToString:@"Main"]) {
    
    //Loading.
    _loadingPanel.frame = CGRectMake(0, 40, _loadingPanel.frame.size.width, _loadingPanel.frame.size.height);
    
    [self action_grabData];
    
    //}
    
    
    
    
    
    
    
    
    
    
    
    
    
    //Setting.
    _Setting_Display = @"";
    _Setting_Sound = @"";
    _Setting_Vibrate = @"";
    _Setting_Value = @"";
    
    _TriggeSpot = @"";
    _nearSpot = @"";
    
    // Get the stored data before the view loads
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    _Setting_Display = [defaults objectForKey:@"Setting_Display"];
    
    
    if ([_Setting_Display isEqualToString:@"0"]) {
        
        vw_displayPanel.hidden = YES;
        
    }else{
        
        //Setting.
        _Setting_Sound = [defaults objectForKey:@"Setting_Sound"];
        _Setting_Vibrate = [defaults objectForKey:@"Setting_Vibrate"];
        _Setting_Value = [defaults objectForKey:@"Setting_Value"];
        
        
        
        vw_displayPanel.hidden = NO;
        
        
    }
    
    NSLog(@"_Setting_Display : %@ === defaults : %@", _Setting_Display, defaults);
    
    
    
    //Follow User
    if ([[defaults objectForKey:@"Setting_Follow"] isEqualToString:@"1"]) {
        _followUser = @"true";
    }else{
        _followUser = @"false";
    }
    
    
    ////////////////////////
    
    
    
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
    
    
    //cell.textLabel.text = @"Promotion 100";
    UILabel *titleLabelV1 = (UILabel *)[cell viewWithTag:1001];
    titleLabelV1.text = [NSString stringWithFormat:@"Promotion %d", indexPath.row];
    
    
    
    UIImageView *titleLabel_new = (UIImageView *)[cell viewWithTag:200];
    
    if (indexPath.row %2 == 0) {
        titleLabel_new.image = [UIImage imageNamed:@"promo1.png"];
        
        NSLog(@"promo2.png");
    }else if (indexPath.row %3 == 0) {
        titleLabel_new.image = [UIImage imageNamed:@"promo2.png"];
        NSLog(@"promo3.png");
    }else{
        titleLabel_new.image = [UIImage imageNamed:@"promo3.png"];
        
        NSLog(@"promo1.png");
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
    [self.myTableAll deselectRowAtIndexPath:indexPath animated:YES];
    
    
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    
    
    DetailViewController *rvController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailView"];
    [self.navigationController pushViewController:rvController animated:YES];
    
    
}


- (void)viewDidUnload {
    [self setMyScroll:nil];
    [self setMyTableAll:nil];
    [self setVw_panel_menu:nil];
    [self setMyMap:nil];
    
    
    [self setMyMap:nil];
    [self setMyMapSegment:nil];
    [self setVw_alert:nil];
    [self setLbl_alert:nil];
    [self setLbl_title:nil];
    [self setLbl_warning_distance:nil];
    [self setLbl_distance:nil];
    [self setLbl_speedLimit:nil];
    [self setLbl_nearSpot:nil];
    [self setBtn_followUser:nil];
    [self setVw_displayPanel:nil];
    [self setBtn_goSubmit:nil];
    [self setBtn_1:nil];
    [self setBtn_2:nil];
    [self setBtn_3:nil];
    [self setBtn_4:nil];
    [self setBtn_5:nil];
    [self setBtn_6:nil];
    [self setBtn_7:nil];
    [super viewDidUnload];
    
    
    
    [super viewDidUnload];
}




- (void)scrollViewDidScroll:(UIScrollView *)sender {
    
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.myScroll.frame.size.width;
    int page = floor((self.myScroll.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    //self.myPageControl.currentPage = page;
    
    
    //_currentIndexInterior = page;
    
    //[self action_checkNextPrevButton];
    
    
    if (self.myScroll.contentOffset.x == 320) {
        //[self action_doFancy];
    }
    
    
    if (page == 0) {
        [self.view endEditing:YES];
        [self actionRelocate:nil];
    }
    
}



- (IBAction)action_menu_show:(id)sender {
    
    //From
    self.vw_panel_menu.frame = CGRectMake(0, 460, self.vw_panel_menu.frame.size.width, self.vw_panel_menu.frame.size.height);
    
    
    //To
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.vw_panel_menu.frame = CGRectMake(0, 0, self.vw_panel_menu.frame.size.width, self.vw_panel_menu.frame.size.height);
                     }
                     completion:nil];
    
}

- (IBAction)action_menu_close:(id)sender {
    
    //From
    self.vw_panel_menu.frame = CGRectMake(0, 0, self.vw_panel_menu.frame.size.width, self.vw_panel_menu.frame.size.height);
    
    
    //To
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.vw_panel_menu.frame = CGRectMake(0, 460, self.vw_panel_menu.frame.size.width, self.vw_panel_menu.frame.size.height);
                     }
                     completion:nil];
    
}

- (IBAction)action_goMain:(id)sender {
    
    //GOTO.
    CGRect frame = self.myScroll.frame;
    
    float pageNumberYouWantToGoTo = 0;
    
    frame.origin.x = frame.size.width * pageNumberYouWantToGoTo;
    frame.origin.y = 0;
    [self.myScroll scrollRectToVisible:frame animated:YES];
    
}

- (IBAction)action_endKeyboard:(id)sender {
    
    [sender resignFirstResponder];
}





///////////////////
- (void)viewWillDisappear:(BOOL)animated {
	
	[super viewWillDisappear:animated];
    
    
    
    NSLog(@"viewWillDisappear");
    
    vw_triggerBg.backgroundColor = [UIColor yellowColor];
    
    
    // Enable the idle timer
    [[UIApplication sharedApplication] setIdleTimerDisabled: NO];
    
    
    myMap.showsUserLocation = NO;
    
    
    locationManager = [[CLLocationManager alloc] init];
    [self.locationManager stopUpdatingLocation];
    [self.locationManager stopMonitoringSignificantLocationChanges];
    self.locationManager.delegate = nil;
    self.locationManager = nil;
    
    //Full screen
    self.navigationController.navigationBarHidden = NO;
    
    
    _loadingPanel.hidden = TRUE;
    
    
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [_loadingWindowAlert dismissWithClickedButtonIndex:0 animated:YES];
    [tConnection cancel];
    tConnection = nil;
    
    
    self.myMap.delegate = nil;
}


- (void)action_doFancy{
    
    //From
    self.btn_1.frame = CGRectMake(300, 70, self.btn_1.frame.size.width, self.btn_1.frame.size.height);
    
    
    //To
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.btn_1.frame = CGRectMake(267, 70, self.btn_1.frame.size.width, self.btn_1.frame.size.height);
                     }
                     completion:nil];
    
    
    //From
    self.btn_2.frame = CGRectMake(300, 124, self.btn_2.frame.size.width, self.btn_2.frame.size.height);
    
    
    //To
    [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.btn_2.frame = CGRectMake(267, 124, self.btn_2.frame.size.width, self.btn_2.frame.size.height);
                     }
                     completion:nil];
    
    
    //From
    self.btn_3.frame = CGRectMake(300, 178, self.btn_3.frame.size.width, self.btn_3.frame.size.height);
    
    
    //To
    [UIView animateWithDuration:1.5 delay:0.0 options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.btn_3.frame = CGRectMake(267, 178, self.btn_3.frame.size.width, self.btn_3.frame.size.height);
                     }
                     completion:nil];
    
    
    
    //From
    self.btn_4.frame = CGRectMake(300, 232, self.btn_4.frame.size.width, self.btn_4.frame.size.height);
    
    
    //To
    [UIView animateWithDuration:2.0 delay:0.0 options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.btn_4.frame = CGRectMake(267, 232, self.btn_4.frame.size.width, self.btn_4.frame.size.height);
                     }
                     completion:nil];
    
    
    //From
    self.btn_5.frame = CGRectMake(300, 286, self.btn_5.frame.size.width, self.btn_5.frame.size.height);
    
    
    //To
    [UIView animateWithDuration:2.5 delay:0.0 options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.btn_5.frame = CGRectMake(267, 286, self.btn_5.frame.size.width, self.btn_5.frame.size.height);
                     }
                     completion:nil];
    
    
    
    //From
    self.btn_6.frame = CGRectMake(300, 340, self.btn_6.frame.size.width, self.btn_6.frame.size.height);
    
    
    //To
    [UIView animateWithDuration:3.0 delay:0.0 options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.btn_6.frame = CGRectMake(267, 340, self.btn_6.frame.size.width, self.btn_6.frame.size.height);
                     }
                     completion:nil];
    
    
    
    //From
    self.btn_7.frame = CGRectMake(300, 394, self.btn_7.frame.size.width, self.btn_7.frame.size.height);
    
    
    //To
    [UIView animateWithDuration:3.5 delay:0.0 options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.btn_7.frame = CGRectMake(267, 394, self.btn_7.frame.size.width, self.btn_7.frame.size.height);
                     }
                     completion:nil];
    
    
    
}




- (void)action_grabData{
    
    NSLog(@"action_grabData");
    
    //Loading.
    //UIAlertView *_loadingWindowAlert;
    
    
    _loadingWindowAlert = [[UIAlertView alloc] initWithTitle:@"Grabbing Gallery\nPlease Wait..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    
    if (dataArray == (id)[NSNull null]) {
        //[_loadingWindowAlert show];
        _loadingPanel.hidden = FALSE;
    }
    
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    // Adjust the indicator so it is up a few pixels from the bottom of the alert
    indicator.center = CGPointMake(_loadingWindowAlert.bounds.size.width / 2, _loadingWindowAlert.bounds.size.height - 50);
    [indicator startAnimating];
    [_loadingWindowAlert addSubview:indicator];
    
    
    
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    
    receivedData = [NSMutableData data];
    
    NSString *event_list_URL = [NSString stringWithFormat:@"http://tomatoits.com/project/smum/webservices/promo_merchant_list.php"];
    NSMutableURLRequest *tRequest = [NSMutableURLRequest requestWithURL:
                                     [NSURL URLWithString:event_list_URL] cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                        timeoutInterval:60.0];
    [tRequest setHTTPMethod:@"POST"];
    
    
    NSString *stringBoundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",stringBoundary];
    [tRequest addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *postBody = [NSMutableData data];
    
    
    
    [postBody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"get_store_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"3"] dataUsingEncoding:NSUTF8StringEncoding]];  // Shop ID
    
    
    
    
    [postBody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [tRequest setHTTPBody:postBody];
    tConnection=[[NSURLConnection alloc] initWithRequest:tRequest delegate:self];
    
    if (tConnection) {
        // Create the NSMutableData to hold the received data.
        // receivedData is an instance variable declared elsewhere.
        //receivedData = [NSMutableData data];
        //NSLog(@"theRequest: %@", tRequest);
    } else {
        // Inform the user that the connection failed.
        //[activityIndicator stopAnimating];
        
        [_loadingWindowAlert dismissWithClickedButtonIndex:0 animated:YES];
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Failed"
                                                        message:@"Connection Failed"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Go",nil];
        [alert show];
        
        //Read Local Data.
        [self action_readLocalData];
        
        
    }
    
    
}


//Start Connection.
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    [receivedData appendData:data];
    
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    //[activityIndicator stopAnimating];
    
    _loadingPanel.hidden = TRUE;
    
    [_loadingWindowAlert dismissWithClickedButtonIndex:0 animated:YES];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    
    NSString * errorConnectMsg = [error localizedDescription];
    
    /*
     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Error"
     message:errorConnectMsg
     delegate:self
     cancelButtonTitle:@"Cancel"
     otherButtonTitles:nil];
     [alert show];
     */
    
    vw_alert.hidden = NO;
    lbl_alert.text = errorConnectMsg;
    
    
    //From
    vw_alert.frame = CGRectMake(-320, 44, vw_alert.frame.size.width, vw_alert.frame.size.height);
    
    
    //To
    [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationTransitionCurlUp
                     animations:^{
                         vw_alert.frame = CGRectMake(0, 44, vw_alert.frame.size.width, vw_alert.frame.size.height);
                     }
                     completion:nil];
    
    
    
    
    
    
    //Read Local Data.
    [self action_readLocalData];
    
    
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    //[activityIndicator stopAnimating];
    
    _loadingPanel.hidden = TRUE;
    
    [_loadingWindowAlert dismissWithClickedButtonIndex:0 animated:YES];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    NSString *responseString = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    
    results = [responseString JSONValue];
    
    dataArray = [results objectForKey:@"Children"];
    
    
    
    //Check data count.
    if(([dataArray isEqual:[NSNull null]]) || [dataArray count] == 0){
        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Search Results"
                                                        message:@"No Results Found"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:nil];
        [alert show];
        
        //Read Local Data.
        [self action_readLocalData];
        
    }else{
        
        [self plotAnno];
        
        //Write to file.
        NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *path_PictureGallery = [rootPath stringByAppendingPathComponent:@"Data_TrafficMapAround.txt"];
        NSString *_PictureGalleryData = responseString;
        //[_PictureGalleryData writeToFile:path_PictureGallery atomically:YES];
        [_PictureGalleryData writeToFile:path_PictureGallery atomically:YES];
        
        
        NSLog(@"write _PictureGalleryData");
        
        
        
    }
    
    
    [tConnection cancel];
    tConnection = nil;
    
    
}




- (void)action_readLocalData{
    
    
    //Read file.
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path_PictureGallery = [rootPath stringByAppendingPathComponent:@"Data_TrafficMapAround.txt"];
    
    NSData *FileData;
    FileData = [NSData dataWithContentsOfFile:path_PictureGallery];
    
    
	if (!FileData)
		NSLog(@"Error - File not found");
    
    
    
    
    
    
    NSString *responseString = [[NSString alloc] initWithData:FileData encoding:NSUTF8StringEncoding];
    
    results = [responseString JSONValue];
    
    dataArray = [results objectForKey:@"Children"];
    
    
    
    //Check data count.
    if(([dataArray isEqual:[NSNull null]]) || [dataArray count] == 0){
        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Search Results"
                                                        message:@"No Results Found"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:nil];
        [alert show];
        
    }else{
        
        [self plotAnno];
        
        NSLog(@"action_readLocalData");
        
    }
    
    
    
    
}










- (IBAction)actionRelocate:(id)sender {
    
    self.myMap.centerCoordinate = myMap.userLocation.location.coordinate;
    
}

- (IBAction)refreshData:(id)sender {
    
    [self action_grabData];
    
    
}

- (IBAction)segmentedMapControlIndexChanged:(id)sender {
    
    switch (self.myMapSegment.selectedSegmentIndex) {
		case 0:
			self.myMap.mapType = MKMapTypeStandard;
			break;
		case 1:
			self.myMap.mapType = MKMapTypeSatellite;
			break;
        case 2:
			self.myMap.mapType = MKMapTypeHybrid;
			break;
		default:
            break;
    }
    
}

- (IBAction)action_goBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}





- (void)mapView:(MKMapView *)mapView
didUpdateUserLocation:
(MKUserLocation *)userLocation
{
    
    NSLog(@"didUpdateUserLocation");
    
    if (startLocation == nil){
        startLocation = userLocation.location;
        
        
        //Zoom.
        // 1
        CLLocationCoordinate2D zoomLocation;
        zoomLocation.latitude = userLocation.location.coordinate.latitude;
        zoomLocation.longitude = userLocation.location.coordinate.latitude;
        // 2
        MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 3500, 3500);
        // 3
        MKCoordinateRegion adjustedRegion = [myMap regionThatFits:viewRegion];
        // 4
        [myMap setRegion:adjustedRegion animated:YES];
        
        
        self.myMap.centerCoordinate = userLocation.location.coordinate;
    }
    
    
    
    
    if ([_followUser isEqualToString:@"true"]) {
        self.myMap.centerCoordinate = userLocation.location.coordinate;
    }
    
    
    lbl_distance.text = [[NSString alloc] initWithFormat:@"%g m.", userLocation.location.horizontalAccuracy];
    
    //self.myMap.centerCoordinate = userLocation.location.coordinate;
}




- (void)plotAnno{
    
    
    [self plotCrimePositions];
    
    /*
     
     
     for (id<MKAnnotation> annotation in myMap.annotations) {
     if (![annotation isKindOfClass:[MKUserLocation class]]){
     [myMap removeAnnotation:annotation];
     }
     
     }
     
     
     
     
     NSUInteger count = [dataArray count];
     for (NSUInteger i = 0; i < count; i++) {
     NSNumber *gps_lat = [[dataArray objectAtIndex: i] objectForKey:@"latitude"];
     NSNumber *gps_long = [[dataArray objectAtIndex: i] objectForKey:@"longitude"];
     
     
     
     
     NSString * shop_name = [NSString stringWithFormat:@"%@ km/j - %@", [self removeTag:[[dataArray objectAtIndex: i] objectForKey:@"speed_limit"]], [self removeTag:[[dataArray objectAtIndex: i] objectForKey:@"route_no"]]];
     NSString * shop_address = [self removeTag:[[dataArray objectAtIndex: i] objectForKey:@"location_name"]];
     NSString * shop_contact = [self removeTag:[[dataArray objectAtIndex: i] objectForKey:@"speed_limit"]];
     
     NSUInteger cdDataArrayIndex = i;
     
     CLLocationCoordinate2D location;
     location.latitude = gps_lat.doubleValue;
     location.longitude = gps_long.doubleValue;
     
     MapViewAnnotation *newAnnotation = [[MapViewAnnotation alloc] initWithName:shop_name address:shop_address coordinate:location operationHour:shop_contact cdDataArrayIndex:cdDataArrayIndex];
     [self.myMap addAnnotation:newAnnotation];
     
     
     
     
     
     }
     
     
     
     */
    
    
    
    
    
}

/*
 
 
 - (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
 {
 NSLog(@"viewForAnnotation");
 
 static NSString *identifier = @"MapViewAnnotation";
 if ([annotation isKindOfClass:[MapViewAnnotation class]]) {
 
 MKPinAnnotationView   *annotationView = (MKPinAnnotationView   *) [myMap dequeueReusableAnnotationViewWithIdentifier:identifier];
 if (annotationView == nil) {
 annotationView = [[MKPinAnnotationView   alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
 NSLog(@"annotationView == nil");
 } else {
 annotationView.annotation = annotation;
 NSLog(@"annotationView != nil");
 }
 
 annotationView.enabled = YES;
 annotationView.canShowCallout = YES;
 annotationView.image=[UIImage imageNamed:@"pin-32x39.png"];//here we use a nice image instead of the default pins
 
 annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
 
 
 return annotationView;
 }
 
 return nil;
 
 }
 
 */


- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
	
    
    MyLocation *myLoc = (MyLocation *)view.annotation;
    
    /*
     
     ChildcareDetailViewController *rvController = [self.storyboard instantiateViewControllerWithIdentifier:@"ChildcareDetailView"];
     
     rvController.cdDicData = [dataArray objectAtIndex:myLoc.cdDataArrayIndex];
     
     [self.navigationController pushViewController:rvController animated:YES];
     */
    
    
    DetailViewController *rvController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailView"];
    [self.navigationController pushViewController:rvController animated:YES];
    
}






- (NSString *)removeTag:(NSString *)string {
    
    
    string = [string stringByReplacingOccurrencesOfString:@"\\n" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\\t" withString:@""];
    
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    
	return string;
    
}












- (IBAction)action_locateNearestSpot:(id)sender {
    
    //Zoom.
    // 1
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = [_nearLat doubleValue];
    zoomLocation.longitude = [_nearLong doubleValue];
    // 2
    //MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 1500, 1500);
    // 3
    //MKCoordinateRegion adjustedRegion = [myMap regionThatFits:viewRegion];
    // 4
    //[myMap setRegion:adjustedRegion animated:YES];
    
    self.myMap.centerCoordinate = zoomLocation;
    
    vw_triggerBg.backgroundColor = [UIColor yellowColor];
    
    
}


- (IBAction)action_followUser:(id)sender {
    
    if ([_followUser isEqualToString:@"true"]) {
        _followUser = @"false";
        btn_followUser.titleLabel.text = @"false";
    }else{
        
        _followUser = @"true";
        btn_followUser.titleLabel.text = @"true";
        
    }
    
    
}






//Plot Anno.
// Add new method above refreshTapped
- (void)plotCrimePositions{
    
    /*
     //Start Method 1.
     //Get the current user location annotation.
     id userAnnotation=myMap.userLocation;
     
     //Remove all added annotations
     [myMap removeAnnotations:myMap.annotations];
     
     // Add the current user location annotation again.
     if(userAnnotation!=nil)
     [myMap addAnnotation:userAnnotation];
     
     
     
     //End Method 1.
     
     */
    
    
    //Start Method 2.
    id userAnnotation = self.myMap.userLocation;
    
    NSMutableArray *annotations = [NSMutableArray arrayWithArray:self.myMap.annotations];
    [annotations removeObject:userAnnotation];
    
    [self.myMap removeAnnotations:annotations];
    //End Method 2.
    
    
    
    
    
    
    /*
     for (id<MKAnnotation> annotation in myMap.annotations) {
     [myMap removeAnnotation:annotation];
     
     }
     */
    
    NSUInteger count = [dataArray count];
    for (NSUInteger i = 0; i < count; i++) {
        
        if([[[dataArray objectAtIndex: i] objectForKey:@"location_lat"] length] > 1 && [[[dataArray objectAtIndex: i] objectForKey:@"location_long"] length] > 1){
            
            NSLog(@"PLOTTING");
            
            NSNumber * latitude = [[dataArray objectAtIndex: i] objectForKey:@"location_lat"];
            NSNumber * longitude = [[dataArray objectAtIndex: i] objectForKey:@"location_long"];
            NSString * crimeDescription = [NSString stringWithFormat:@"%@", [self removeTag:[[dataArray objectAtIndex: i] objectForKey:@"centre_name"]]];
            NSString * address = [self removeTag:[[dataArray objectAtIndex: i] objectForKey:@"location_name"]];
            
            NSUInteger cdDataArrayIndex = i;
            
            CLLocationCoordinate2D coordinate;
            coordinate.latitude = latitude.doubleValue;
            coordinate.longitude = longitude.doubleValue;
            MyLocation *annotation = [[MyLocation alloc] initWithName:crimeDescription address:address coordinate:coordinate cdDataArrayIndex:cdDataArrayIndex] ;
            [myMap addAnnotation:annotation];
            
        }
        
        
        
        
    }
    
    
    
    
    
    
}






#pragma mark - View lifecycle


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    if (annotation == myMap.userLocation) {
        
        NSLog(@"annotation == myMap.userLocation");
        return nil;
    }
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        
        NSLog(@"[annotation isKindOfClass:[MKUserLocation class]");
        return nil;
        
    }
    
    
    myMap.showsUserLocation = YES;
    
    
    
    static NSString *identifier = @"MyLocation";
    if ([annotation isKindOfClass:[MyLocation class]]) {
        
        NSLog(@"[annotation isKindOfClass:[MyLocation class]]");
        
        MKAnnotationView *annotationView = (MKAnnotationView *) [myMap dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        } else {
            annotationView.annotation = annotation;
        }
        
        annotationView.enabled = YES;
        annotationView.canShowCallout = YES;
        annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        
        annotationView.image=[UIImage imageNamed:@"pin-32x39.png"];//here we use a nice image instead of the default pins
        
        
        //annotationView.centerOffset = CGPointMake(-8, -4.5);
        
        annotationView.centerOffset = CGPointMake(0, -annotationView.image.size.height/2);
        
        
        
        
        
        /*
         UIImage *pinImage = [UIImage imageNamed:@"pin-32x39.png"];
         
         UIImageView *imageView = [[UIImageView alloc] initWithImage:pinImage];
         
         imageView.frame = CGRectMake(-8, -5, 32, 39);
         
         [annotationView addSubview:imageView];
         */
        
        
        return annotationView;
    }
    
    
    myMap.showsUserLocation = YES;
    
    return nil;
}

- (IBAction)action_search:(id)sender {
    
    [self.view endEditing:YES];
    
}

@end
