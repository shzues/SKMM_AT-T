//
//  MainMenuViewController.h
//  ShoutOutPromo
//
//  Created by DanS on 9/6/13.
//
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@interface MainMenuViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>{
    
    NSURLConnection *tConnection;
    
    CLLocation *startLocation;
    
    
    
}


@property (strong, nonatomic) IBOutlet UIScrollView *myScroll;

@property (strong, nonatomic) IBOutlet UITableView *myTableAll;

@property (strong, nonatomic) IBOutlet UIView *vw_panel_menu;


@property (strong, nonatomic) IBOutlet MKMapView *myMap;


- (IBAction)action_menu_show:(id)sender;
- (IBAction)action_menu_close:(id)sender;


- (IBAction)action_goMain:(id)sender;

- (IBAction)action_endKeyboard:(id)sender;






@property (strong, nonatomic) IBOutlet UIButton *btn_1;
@property (strong, nonatomic) IBOutlet UIButton *btn_2;
@property (strong, nonatomic) IBOutlet UIButton *btn_3;
@property (strong, nonatomic) IBOutlet UIButton *btn_4;
@property (strong, nonatomic) IBOutlet UIButton *btn_5;
@property (strong, nonatomic) IBOutlet UIButton *btn_6;
@property (strong, nonatomic) IBOutlet UIButton *btn_7;



- (IBAction)action_search:(id)sender;




//@end



@property(strong, nonatomic) NSString *cdStore_id;
@property(strong, nonatomic) NSString *cdStore_title;
- (IBAction)action_goBack:(id)sender;


@property(strong, nonatomic) NSMutableData *receivedData;
@property(strong, nonatomic) NSMutableDictionary *results;
@property(strong, nonatomic) NSMutableArray *dataArray;

@property(strong, nonatomic) UIAlertView *_loadingWindowAlert;

@property (strong, nonatomic) IBOutlet UIView *_loadingPanel;

@property (strong, nonatomic) IBOutlet UIView *vw_alert;
@property (strong, nonatomic) IBOutlet UILabel *lbl_alert;


@property (strong, nonatomic) IBOutlet UILabel *lbl_title;

@property (strong, nonatomic) IBOutlet UILabel *lbl_speedLimit;
@property (strong, nonatomic) IBOutlet UILabel *lbl_nearSpot;







@property (strong, nonatomic) IBOutlet UISegmentedControl *myMapSegment;
- (IBAction)actionRelocate:(id)sender;
- (IBAction)refreshData:(id)sender;

- (IBAction)segmentedMapControlIndexChanged:(id)sender;


@property(strong, nonatomic) NSString *cdFromPage;
@property(strong, nonatomic) NSString *cdFetching;
@property(strong, nonatomic) NSString *cdDidUpdateUserLocation;

@property (strong, nonatomic) CLLocation *startLocation;



@property(strong, nonatomic) CLLocationManager * locationManager;


@property (strong, nonatomic) IBOutlet UIView *vw_triggerBg;






@property (strong, nonatomic) IBOutlet UILabel *lbl_warning_distance;
@property (strong, nonatomic) IBOutlet UILabel *lbl_distance;

@property (strong, nonatomic) IBOutlet UIView *vw_displayPanel;


//Near SPot.
@property(strong, nonatomic) NSString * _nearLong;
@property(strong, nonatomic) NSString * _nearLat;
- (IBAction)action_locateNearestSpot:(id)sender;



@property(strong, nonatomic) NSString * _followUser;

- (IBAction)action_followUser:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btn_followUser;






@property (strong, nonatomic) IBOutlet UIButton *btn_goSubmit;




//Setting.
@property(strong, nonatomic) NSString * _Setting_Display;
@property(strong, nonatomic) NSString * _Setting_Sound;
@property(strong, nonatomic) NSString * _Setting_Vibrate;
@property(strong, nonatomic) NSString * _Setting_Value;
@property(strong, nonatomic) NSString * _TriggeSpot;
@property(strong, nonatomic) NSString * _nearSpot;



@end







