//
//  AXCViewController.m
//  AXCGiphy
//
//  Created by Alex Choi on 08/19/2014.
//  Copyright (c) 2014 Alex Choi. All rights reserved.
//

#import "AXCViewController.h"
#import <AXCGiphy/AXCGiphy.h>
#import "AXCCollectionViewCell.h"
#import <AnimatedGIFImageSerialization/AnimatedGIFImageSerialization.h>

NSString * const kCollectionViewCellIdentifier = @"cellReuseIdentifier";
@interface AXCViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (strong, nonatomic) NSArray * giphyResults;
@property (weak, nonatomic) IBOutlet UICollectionView * collectionView;
@end

@implementation AXCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // set your API key before making any requests. You may use kGiphyPublicAPIKey for development.
    [AXCGiphy setGiphyAPIKey:kGiphyPublicAPIKey];
   
    // see the methods below for usage examples
    [self searchForFrogs];
}

- (void) getTranslation
{
    [AXCGiphy giphyTranslationForTerm:@"frog" completion:^(AXCGiphy *result, NSError *error) {
        self.giphyResults = @[result];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.collectionView reloadData];
        }];
    }];
}

- (void) getSingleGIF
{
    [AXCGiphy gifForID: @"dc6zaTOxFJmzC" completion:^(AXCGiphy *result, NSError *error) {
        self.giphyResults = @[result];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.collectionView reloadData];
        }];
    }];
}

-(void) getSpecificGIFs
{
    [AXCGiphy gifsForIDs:@[ @"dc6zaTOxFJmzC", @"feqkVgjJpYtjy"] completion:^(NSArray *results, NSError *error) {
        self.giphyResults = results;
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.collectionView reloadData];
        }];
    }];
}

- (void) getTrending
{
    [AXCGiphy trendingGIFsWithlimit:10 offset:0 completion:^(NSArray *results, NSError *error) {
        self.giphyResults = results;
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.collectionView reloadData];
        }];
    }];
}

- (void) searchForFrogs
{
    NSURLSessionDataTask * task = [AXCGiphy searchGiphyWithTerm:@"frogs" limit:10 offset:0 completion:^(NSArray *results, NSError *error) {
        self.giphyResults = results;
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.collectionView reloadData];
        }];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UICollectionViewDataSource
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.giphyResults.count;
}
- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AXCCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewCellIdentifier forIndexPath:indexPath];
    AXCGiphy * gif = self.giphyResults[indexPath.item];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:gif.originalImage.url];
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        UIImage * image = [UIImage imageWithData:data];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            cell.imageView.image = image;
        }];
    }] resume];
    
    return cell;
}
@end
