//
//  HomeInfoViewController.m
//  Rebif
//
//  Created by Omer Janjua on 09/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomerInfoViewController.h"

@interface CustomerInfoViewController ()
-(void)setupNav;

@end

@implementation CustomerInfoViewController
@synthesize webView=_webView;
@synthesize thisTitle=_thisTitle;
@synthesize link=_link;


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNav];
    self.webView.delegate = self;    
    if (self.link)
    {
        [self.webView loadRequest:[NSURLRequest requestWithURL: self.link]];
    }
}

//pressing this cancel button on the leftbarbutton will modally dismiss the view 
-(void)setupNav
{
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelPressed:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    self.title = @"Document";
    [self.webView setScalesPageToFit:YES];
}

-(IBAction)cancelPressed:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
