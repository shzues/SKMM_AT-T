//
//  CommentViewController.h
//  ShoutOutPromo
//
//  Created by DanS on 9/7/13.
//
//

#import <UIKit/UIKit.h>

@interface CommentViewController : UIViewController


- (IBAction)action_goBack:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *txt_comment;
@property (strong, nonatomic) IBOutlet UIView *vw_panel_success;

- (IBAction)action_endKeyboard:(id)sender;
- (IBAction)action_submit:(id)sender;
- (IBAction)action_done:(id)sender;

@end
