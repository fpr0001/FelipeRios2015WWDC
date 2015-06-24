//
//  FPRMainViewController.m
//  FelipeRios
//
//  Created by Felipe Polidori Rios on 23/04/15.
//  Copyright (c) 2015 Felipe Polidori Rios. All rights reserved.
//
//
//
#import "FPRMainViewController.h"

#define METERS_PER_MILE 1609.344

@interface FPRMainViewController ()<MKMapViewDelegate, UIScrollViewDelegate>
@property(nonatomic)FPRGradientView* viewGradient;
@property(nonatomic)NSDictionary* data;
@property(nonatomic)NSMutableArray* arrayViewsScrolledPaged;
@property(nonatomic)NSInteger lastPage;
@property(nonatomic)NSInteger currentPage;
@property(nonatomic)FPRViewScrollPaged* viewCurrentPage;
@property(nonatomic)float angle;
@property(nonatomic)float angleInitial;
@end

@implementation FPRMainViewController

-(void)playVideo{
    NSString *path = [[NSBundle mainBundle]pathForResource:
                      @"mercurialMovie" ofType:@"mov"];
    MPMoviePlayerViewController* moviePlayer = [[MPMoviePlayerViewController
                    alloc]initWithContentURL:[NSURL fileURLWithPath:path]];
    [self presentViewController:moviePlayer animated:YES completion:nil];
}

-(void)openWebsite{
    NSURL *url = [NSURL URLWithString:@"http://www.mercurialapp.com/"];
    [[UIApplication sharedApplication] openURL:url];
}


//load data from plist
-(NSDictionary *)data{
    if (!_data) {
        _data = [[FPRData alloc]init].dictionaryData;
    }
    return _data;
}

-(NSMutableArray *)arrayViewsScrolledPaged{
    if (!_arrayViewsScrolledPaged) {
        _arrayViewsScrolledPaged = [[NSMutableArray alloc]init];
        
        for (int i=0; i<self.data.allValues.count; i++) {
            [_arrayViewsScrolledPaged addObject:[NSNull null]];
        }
    }
    return _arrayViewsScrolledPaged;
}

-(void)configurePageControl{
    _currentPage=0;
    _lastPage = 1;
    [self.pageControl setCurrentPage:self.currentPage];
    [self.pageControl setNumberOfPages:self.data.allValues.count];
}

-(void)configureWWDCImage{
    _angleInitial = M_PI_4/2;
    self.imageViewWWDC.transform =CGAffineTransformMakeRotation(_angleInitial);
}

-(void)addGradientView{
    FPRGradientView *view = [[FPRGradientView alloc] initWithFrame:self.view.frame];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = view.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor clearColor] CGColor], (id)[[UIColor blackColor] CGColor], nil];
    [view.layer insertSublayer:gradient atIndex:0];
    [self.view addSubview:view];
    _viewGradient = view;
}

- (NSUInteger) supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - VC LIFE CYCLE

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithRed:248./255. green:244./255. blue:235./255. alpha:1.0]];
    _angle = M_PI_4/2.0;
    
    [self addGradientView];
    [self configureWWDCImage];
    [self configureMapView];
    [self configureScrollView];
}

-(void)viewDidAppear:(BOOL)animated{
    [self.view bringSubviewToFront:self.scrollView];
    [self.view bringSubviewToFront:self.pageControl];
    
    
    //resets the annotation of the current page
    FPRContent* content = [self.data objectForKey:[NSNumber numberWithInteger:self.currentPage]];
    [self putContentInMap:content];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - MAP VIEW

-(void)configureMapView{
    [self.map setDelegate:self];
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    static NSString *identifier = @"annotationIdentifier";
    if ([annotation isKindOfClass:[FPRAnnotation class]]) {
        
        MKAnnotationView *annotationView = (MKAnnotationView *) [self.map dequeueReusableAnnotationViewWithIdentifier:identifier];
        
        if (annotationView == nil) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            annotationView.frame=CGRectMake(0.0, 0.0, IMAGE_VIEW_WIDTH, IMAGE_VIEW_WIDTH);
            UIImageView* imageView = [(FPRAnnotation*)annotation imageView];
            [annotationView addSubview:imageView];
            [imageView setCenter:annotationView.center];
            annotationView.annotation=annotation;
        } else {
            ((UIImageView *)[annotationView viewWithTag:10]).image = [(FPRAnnotation*)annotation imageView].image;
            annotationView.annotation = annotation;
        }
        return annotationView;
    }
    return nil;
}

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    
    //show picture full screen
    FPRAnnotation *location = (FPRAnnotation*)view.annotation;
    FPRPictureViewController* picVC = [[FPRPictureViewController alloc]init];
    [picVC setImage:location.imageView.image];
    [self presentViewController:picVC animated:YES completion:nil];
}

- (void)putContentInMap:(FPRContent*)content {
    
    [self.map removeAnnotations:self.map.annotations];
    
    CLLocationCoordinate2D coordinate;
    coordinate.latitude=content.latitude;
    coordinate.longitude=content.longitude;

    FPRAnnotation *annotation = [[FPRAnnotation alloc] initWithName:content.stringTopic address:content.stringTopic coordinate:coordinate];
    [annotation setContent:content];

    [self.map addAnnotation:annotation];
    
    MKCoordinateSpan span = MKCoordinateSpanMake(.1, .1);
    [self.map setRegion:MKCoordinateRegionMake(coordinate, span) animated:YES];

}

#pragma mark - SCROLL VIEW

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    //rotate imageView according to scrollview content offset
    float diffCurrentViewToScroll = scrollView.contentOffset.x-self.viewCurrentPage.frame.origin.x;
    float percentScrolled = diffCurrentViewToScroll/self.view.frame.size.width;

    _angle = _angleInitial - M_PI_4*self.currentPage - M_PI_4*percentScrolled;
    
    self.imageViewWWDC.transform =CGAffineTransformMakeRotation(_angle);
}


-(void)configureScrollView{
    [self.scrollView setDelegate:self];
    CGSize pagesScrollViewSize = self.scrollView.frame.size;
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width * self.arrayViewsScrolledPaged.count, pagesScrollViewSize.height);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.scrollsToTop = NO;
    [self.view bringSubviewToFront:self.scrollView];
    
    [self configurePageControl];
    [self loadVisiblePages];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.view.frame.size.width;
    NSUInteger page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.lastPage=self.currentPage;
    self.currentPage=page;
    self.pageControl.currentPage=page;
    
    [self loadVisiblePages];
}



- (void)loadVisiblePages {
    
    NSInteger page = self.currentPage;
    
    NSInteger firstPage = page - 1;
    NSInteger lastPage = page + 1;
    
    for (NSInteger i=0; i<firstPage; i++) {
        [self purgePage:i];
    }
    for (NSInteger i=firstPage; i<=lastPage; i++) {
        [self loadPage:i];
    }
    for (NSInteger i=lastPage+1; i<self.data.allValues.count; i++) {
        [self purgePage:i];
    }
}

- (void)loadPage:(NSInteger)page {
    
    //if it is out of range, do nothing
    if (page < 0 || page >= self.data.allValues.count) {
        return;
    }
    
    FPRViewScrollPaged *pageView = [self.arrayViewsScrolledPaged objectAtIndex:page];
    
    if ((NSNull*)pageView == [NSNull null]) {
        
        CGRect frame = self.scrollView.frame;
        frame.origin.x = self.view.frame.size.width * page;
        frame.origin.y = 0;
        
        FPRContent* content = [self.data objectForKey:[NSNumber numberWithInteger:page]];
        FPRViewScrollPaged* view = [[FPRViewScrollPaged alloc]initWithFrame:frame andContent:content];

        
        //customize Mercurial view
        if ([content.stringSubtopic isEqualToString:@"Mercurial"]) {
            [view.buttonVideo setHidden:NO];
            [view.buttonVideo addTarget:self action:@selector(playVideo) forControlEvents:UIControlEventTouchUpInside];
            
            [view.buttonWebsite setHidden:NO];
            [view.buttonWebsite addTarget:self action:@selector(openWebsite) forControlEvents:UIControlEventTouchUpInside];
        }
        
        [self.scrollView addSubview:view];
        [self.arrayViewsScrolledPaged replaceObjectAtIndex:page withObject:view];
        
        if (page==self.currentPage) {
            [self putContentInMap:content];
            self.viewCurrentPage=view;
        }
    }
    else{
        
        if (page==self.currentPage) {
            FPRContent* content = [self.data objectForKey:[NSNumber numberWithInteger:page]];
            [self putContentInMap:content];
            self.viewCurrentPage=pageView;
        }
    }
    
}

- (void)purgePage:(NSInteger)page {
    if (page < 0 || page >= self.arrayViewsScrolledPaged.count) {
        return;
    }
    
    UIView *pageView = [self.arrayViewsScrolledPaged objectAtIndex:page];
    if ((NSNull*)pageView != [NSNull null]) {
        [pageView removeFromSuperview];
        [self.arrayViewsScrolledPaged replaceObjectAtIndex:page withObject:[NSNull null]];
    }
}

@end
