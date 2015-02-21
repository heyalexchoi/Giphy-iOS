# Giphy-iOS
<!--- [![CI Status](http://img.shields.io/travis/Alex Choi/AXCGiphy.svg?style=flat)](https://travis-ci.org/Alex Choi/AXCGiphy) --> 
[![Version](https://img.shields.io/cocoapods/v/Giphy-iOS.svg?style=flat)](http://cocoadocs.org/docsets/Giphy-iOS)
[![License](https://img.shields.io/cocoapods/l/Giphy-iOS.svg?style=flat)](http://cocoadocs.org/docsets/Giphy-iOS)
[![Platform](https://img.shields.io/cocoapods/p/Giphy-iOS.svg?style=flat)](http://cocoadocs.org/docsets/Giphy-iOS)

Giphy-iOS is a [Giphy API](https://github.com/Giphy/GiphyAPI) client for iOS in Objective-C.


## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

You should read about [Giphy's Access and API keys here](https://github.com/Giphy/GiphyAPI#access-and-api-keys).

### Giphy-iOS / AXCGiphy
'AXCGiphy' provides convenient access to [Giphy's API](https://github.com/Giphy/GiphyAPI) endpoints:

- search
- trending
- translate
- GIF by ID
- GIFs by IDs

You can query the endpoints through the blocks based interface:


```objective-c

- (void)viewDidLoad
{
    [super viewDidLoad];
	// set your API key before making any requests. You may use kGiphyPublicAPIKey for development.
    [AXCGiphy setGiphyAPIKey:kGiphyPublicAPIKey];

    [AXCGiphy searchGiphyWithTerm:@"frogs" limit:10 offset:0 completion:^(NSArray *results, NSError *error) {
        self.giphyResults = results;
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.collectionView reloadData];
        }];
    }];
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

```

AXCGiphy blocks based class methods provide asynchronous access to either AXCGiphy instances or an NSArray of AXCGiphy instances. AXCGiphy instances represent Giphy's gifs and their metadata. However, AXCGiphy only provides URLs to gifs. How you use these URLs is up to you.

My example uses NSURLRequests with NSURLSession to fetch the image data at the URLs and [mattt's AnimatedGifSerialization](https://github.com/mattt/AnimatedGIFImageSerialization) to decode the animated GIFs into animated UIImages. If you are unsure of how to proceed, use my example app as a starting point.

The blocks based class methods return NSURLSessionDataTasks for additional control, should you need it.

AXCGiphy also provides class methods to generate NSURLRequests for these endpoints.



## Requirements

AFNetworking/Serialization 2.3.1


## Installation

Giphy-iOS is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "Giphy-iOS"
    pod 'AFNetworking/Serialization', '~> 2.3.1'

## Author

Alex Choi, heyalexchoi@gmail.com

## License

Giphy-iOS is available under the MIT license. See the LICENSE file for more info.
