//
//  MainMenuViewController.h
//  ShoutOutMerchant
//
//  Created by DanS on 9/8/13.
//
//

#import <UIKit/UIKit.h>

@interface MainMenuViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIScrollView *myScroll;



- (IBAction)action_keyboard_close:(id)sender;
@property (strong, nonatomic) IBOutlet UITextView *txt_content;

@property (strong, nonatomic) IBOutlet UIButton *btn_content;
@property (strong, nonatomic) IBOutlet UIImageView *img_upload;

@property (strong, nonatomic) IBOutlet UIImageView *img_token_1;
@property (strong, nonatomic) IBOutlet UIImageView *img_token_2;
@property (strong, nonatomic) IBOutlet UIImageView *img_token_3;

@property (strong, nonatomic) IBOutlet UIButton *btn_time_1;
@property (strong, nonatomic) IBOutlet UIButton *btn_time_2;
@property (strong, nonatomic) IBOutlet UIButton *btn_time_3;


- (IBAction)action_time_1:(id)sender;
- (IBAction)action_time_2:(id)sender;
- (IBAction)action_time_3:(id)sender;


@property (strong, nonatomic) IBOutlet UIImageView *img_timeoption_1;
@property (strong, nonatomic) IBOutlet UIImageView *img_timeoption_2;
@property (strong, nonatomic) IBOutlet UIImageView *img_timeoption_3;

@property (strong, nonatomic) IBOutlet UIScrollView *myScroll_timeoption;

- (IBAction)action_timeoption_close:(id)sender;
- (IBAction)action_camera:(id)sender;

- (IBAction)action_keyboard_end:(id)sender;
- (IBAction)action_success_close:(id)sender;


- (IBAction)action_reset:(id)sender;

@property(strong, nonatomic) NSString *cdCurTimeSlot;

@property (strong, nonatomic) IBOutlet UITextField *txt_coordinate;

@property (strong, nonatomic) IBOutlet UIView *vw_panel_status;


- (IBAction)action_submit:(id)sender;


@end
