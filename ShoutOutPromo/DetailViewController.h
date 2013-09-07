//
//  DetailViewController.h
//  ShoutOutPromo
//
//  Created by DanS on 9/7/13.
//
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController


- (IBAction)action_goBack:(id)sender;

@property (strong, nonatomic) IBOutlet UITableView *myTableContent;

- (IBAction)action_goComment:(id)sender;
@property (strong, nonatomic) IBOutlet UIScrollView *myScroll;


@end
