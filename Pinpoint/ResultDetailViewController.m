//
//  ResultDetailViewController.m
//  Pinpoint
//
//  Created by Nicolas Rizk on 3/19/15.
//  Copyright (c) 2015 Flatiron School. All rights reserved.
//

#import "ResultDetailViewController.h"
#import "Pinpoint.h"

@interface ResultDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *venueName;
@property (weak, nonatomic) IBOutlet UILabel *venueAddress;
@property (weak, nonatomic) IBOutlet UILabel *googleRating;
@property (weak, nonatomic) IBOutlet UILabel *yelpRating;
@property (weak, nonatomic) IBOutlet UILabel *foursquareRating;
@property (weak, nonatomic) IBOutlet UILabel *googlePrice;
@property (weak, nonatomic) IBOutlet UILabel *foursquarePrice;
@property (weak, nonatomic) IBOutlet UIImageView *venueImage;
@property (weak, nonatomic) IBOutlet UILabel *venuePhone;
@property (weak, nonatomic) IBOutlet UILabel *openOrClosed;


@end

@implementation ResultDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.venueName setText:self.pinPoint.name];
    [self.venueAddress setText:self.pinPoint.address];
    [self.venuePhone setText:self.pinPoint.phoneNumber];
 
    NSString *googleRate = [self concatDecimals:self.pinPoint.googleRating];
    NSString *googleSet = [self outofRating:googleRate highestPossible:@"5"];
    NSString *google = [NSString stringWithFormat:@"Google: %@", googleSet];
    [self.googleRating setText:google];
   
    NSString *foursquareRate = [self concatDecimals:self.pinPoint.foursquareRating];
    NSString *foursquareSet = [self outofRating:foursquareRate highestPossible:@"10"];
    NSString *foursquare = [NSString stringWithFormat:@"Foursquare: %@", foursquareSet];
    [self.foursquareRating setText:foursquare];

    NSString *yelpRate = [self concatDecimals:self.pinPoint.yelpRating];
    NSString *yelpSet = [self outofRating:yelpRate highestPossible:@"5"];
    NSString *yelp = [NSString stringWithFormat:@"Yelp: %@", yelpSet];
    [self.yelpRating setText:yelp];
    
    NSString *googlePriceLevel = [self concatDecimals:self.pinPoint.googlePriceLevel];
    NSString *gSet = [self outofRating:googlePriceLevel highestPossible:@"5"];
    NSString *gPrice = [NSString stringWithFormat:@"Google: %@", gSet];
    [self.googlePrice setText:gPrice];
    
    
    NSString *foursquarePriceLevel = [self concatDecimals:self.pinPoint.fourSquarePriceLevel];
    NSString *fSSet = [self outofRating:foursquarePriceLevel highestPossible:@"5"];
    NSString *fsPrice = [NSString stringWithFormat:@"Foursquare: %@", fSSet];
    [self.foursquarePrice setText:fsPrice];
    
    [self.venueImage setImage:self.pinPoint.image];
    
    if ([self.pinPoint.openNow isEqualToString:@"0"]) {
        [self.openOrClosed setText:@"Closed"];
        self.openOrClosed.textColor = [UIColor redColor];
    } else if ([self.pinPoint.openNow isEqualToString:@"1"]) {
        [self.openOrClosed setText:@"Open"];
        self.openOrClosed.textColor = [UIColor greenColor];
    } else {
           self.openOrClosed.textColor = [UIColor whiteColor];
    }
    
    
    // Do any additional setup after loading the view.
}

-(NSString *)concatDecimals:(NSString *)number {
    if ([number length] > 3) {
        number = [number substringToIndex:4];
    }
    return number;
}

-(NSString *)outofRating:(NSString *)rating highestPossible:(NSString *)score {
    return [NSString stringWithFormat:@"%@ out of %@", rating, score];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
