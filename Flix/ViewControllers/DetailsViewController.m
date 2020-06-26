//
//  DetailsViewController.m
//  Flix
//
//  Created by Ian Andre Aragon Saenz on 24/06/20.
//  Copyright © 2020 IanAragon. All rights reserved.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "TrailerViewController.h"


@interface DetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *movieURL = @"https://image.tmdb.org/t/p/w500";
    //poster
    NSString *posterImageURL = [movieURL stringByAppendingString:self.movie[@"poster_path"]];
    NSURL *posterURL = [NSURL URLWithString:posterImageURL];
    //back Image
    NSString *backImageURL = [movieURL stringByAppendingString:self.movie[@"backdrop_path"]];
    NSURL *backURL = [NSURL URLWithString:backImageURL];
    
    //setting info
    self.posterView.image = nil;
    [self.posterView setImageWithURL:posterURL];
    self.backView.image = nil;
    [self.backView setImageWithURL:backURL];
    
    self.titleLabel.text = self.movie[@"title"];
    self.descriptionLabel.text = self.movie[@"overview"];
    
    [self.titleLabel sizeToFit];
    [self.descriptionLabel sizeToFit];
    
}

- (IBAction)tappedPoster:(id)sender {
    [self performSegueWithIdentifier:@"trailer" sender:nil];
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    TrailerViewController *trailer = [segue destinationViewController];
    trailer.movie = self.movie;
}


@end
