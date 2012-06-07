//
//  HomeInfoViewController.h
//  Rebif
//
//  Created by Omer Janjua on 09/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomerInfoViewController : UIViewController <UIWebViewDelegate>{
    
}
@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) NSURL *link;
@property (nonatomic, retain) NSString *thisTitle;

@end
