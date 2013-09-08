//
//  DetailViewController.h
//  ShoutOutPromo
//
//  Created by DanS on 9/7/13.
//
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController {
    
    NSTimer *myTimer;
    
    
    NSTimer *myTimerClose;
    
}


- (IBAction)action_goBack:(id)sender;

@property (strong, nonatomic) IBOutlet UITableView *myTableContent;

- (IBAction)action_goComment:(id)sender;
@property (strong, nonatomic) IBOutlet UIScrollView *myScroll;



@property (strong, nonatomic) IBOutlet UIView *vw_panel_notif;



- (IBAction)action_endKeyboard:(id)sender;
- (IBAction)action_search:(id)sender;


@property (strong, nonatomic) IBOutlet UILabel *lbl_title;
@property (strong, nonatomic) IBOutlet UILabel *lbl_content;


@property(strong, nonatomic) NSString *cdPromoID;



@end
