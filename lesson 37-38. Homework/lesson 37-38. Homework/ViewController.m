//
//  ViewController.m
//  lesson 37-38. Homework
//
//  Created by Admin on 4/6/16.
//  Copyright (c) 2016 Admin. All rights reserved.
//

#import "ViewController.h"
#import "Student.h"
#import "MapAnnotation.h"
#import "InfoPopoverTVC.h"
#import <AddressBook/ABPerson.h>

typedef enum {
    annotationKindStudent,
    annotationKindMeetingPoint
}kindOfAnnotation;

@interface ViewController () <MKMapViewDelegate, UIPopoverControllerDelegate>

@property (strong, nonatomic) NSMutableArray* studentsArray;
@property (strong, nonatomic) UIPopoverController* popoverProp;
@property (strong, nonatomic) CLGeocoder* geoCoder; //for storing geoCoder info
@property (strong, nonatomic) MKDirections* directions; //for storing directions info
@property (assign, nonatomic) BOOL isAllowedToPick;
@property (assign, nonatomic) BOOL isMeetingPoinExist;
@property (assign, nonatomic) BOOL isShowedAlertBefore;

@property (assign, nonatomic) CLLocationCoordinate2D meetingPointCoordinate; // for creating routes to meeting point
@property (strong, nonatomic) NSMutableArray* annotationsForMeeting;
@property (strong, nonatomic) NSArray* allStudentsAnnotations;

@property (strong, nonatomic) NSMutableArray* groupDistanceZone1;
@property (strong, nonatomic) NSMutableArray* groupDistanceZone2;
@property (strong, nonatomic) NSMutableArray* groupDistanceZone3;
@property (assign, nonatomic) UniCharCount calculationMaxValue;
@property (assign, nonatomic) UniCharCount calculationCounter;
@property (strong, nonatomic) UIView* viewForAnalitic;
@property (strong, nonatomic) UIView* viewForWhoWillCome;

//three radiuses for distance-zones
@property (assign, nonatomic) double radiusForDistZ1;
@property (assign, nonatomic) double radiusForDistZ2;
@property (assign, nonatomic) double radiusForDistZ3;

@property (strong, nonatomic) UIColor* currentColor;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.radiusForDistZ1 = 4000.f;
    self.radiusForDistZ2 = 8000.f;
    self.radiusForDistZ3 = 12000.f;
    
    //0. Loading initial mapview region
//Kharkiv's center
    CLLocationDegrees latitudeCenter = 50.005833;
    CLLocationDegrees longitudeCenter = 36.229167;
    CLLocationCoordinate2D centerOfKharkiv = CLLocationCoordinate2DMake(latitudeCenter, longitudeCenter);
    MKCoordinateSpan spaneForStart = MKCoordinateSpanMake(0.2, 0.2);
    MKCoordinateRegion startRegion = MKCoordinateRegionMake(centerOfKharkiv, spaneForStart);
    [self.mapView setRegion:startRegion];
    
//1. Creating random students
    self.studentsArray = [NSMutableArray array];
    for (int i=0; i<20; i++) {
        Student* student = [Student randomStudent];
        [self.studentsArray addObject:student];
        
//2. Creating and assigning annotation for every student
        MapAnnotation* myAnnotation = [[MapAnnotation alloc] init];
        myAnnotation.kindOfAnnotation = annotationKindStudent;
        myAnnotation.coordinate = student.coordinateStudent;
        myAnnotation.title = [NSString stringWithFormat:@"%@ %@", student.firstName, student.lastName];
        myAnnotation.subtitle = student.dateOfBirthAsString;
        myAnnotation.student = student;
        [self.mapView addAnnotation:myAnnotation];
    }
    self.calculationMaxValue = [self.studentsArray count]; //for using in method (-calculateDistansesFromStudentsToMeetingPoint)

//3. Button with actions @show all students)
    UIBarButtonItem* showAllButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(actionShowAll:)];
    UIBarButtonItem* setAppointmentButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(allowPickPoint:)];
    UIBarButtonItem* makeRoutesButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"road.png"] style:UIBarButtonItemStyleDone target:self action:@selector(actionDrawRoutes:)];
    UIBarButtonItem* calcDistancesButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"calc.png"] style:UIBarButtonItemStylePlain target:self action:@selector(calculateDistansesToMeetingPoint)];
    //UIBarButtonItem* calcDistancesButton = [[UIBarButtonItem alloc] initWithTitle:@"evaluate distances" style:UIBarButtonItemStylePlain target:self action:@selector(calculateDistansesToMeetingPoint)];
    UIBarButtonItem* spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    UIBarButtonItem* stopCalcButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(stopCalculations)];

    self.navigationItem.rightBarButtonItems = @[showAllButton, setAppointmentButton, makeRoutesButton, calcDistancesButton, spaceItem, stopCalcButton];
    makeRoutesButton.enabled = NO; //will enable only after calculation of distances
    calcDistancesButton.enabled = NO; //will enable only after setting a meeting-point
    
    self.geoCoder = [[CLGeocoder alloc] init];

//SS: assigning recognizer for taps
    UITapGestureRecognizer *rec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRecognized:)];
    [self.mapView addGestureRecognizer:rec];
    self.isAllowedToPick = NO;
    self.isMeetingPoinExist = NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - About displaying new VC's
//SS: for iPhone IDIOM.
-(void) showVCAsModal:(UIViewController*) receivedVC {
    [self presentViewController:receivedVC
                       animated:YES
                     completion:^{
                         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                             [self dismissViewControllerAnimated:YES completion:nil];
                         });
                     }];
}
-(void) showInfoTVCForStudent: (Student*) student withAddress: (NSString*) address fromButton: (UIButton*)sender {
    //But we take VC from storyboard, so we must use Identifier
    InfoPopoverTVC* studentInfoTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"IDforInfoPopoverTVC"];
    studentInfoTVC.studentForParsing = student;
    studentInfoTVC.valueForAddress = address;

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        UIPopoverController* infoPopover = [[UIPopoverController alloc] initWithContentViewController:studentInfoTVC];
        [infoPopover presentPopoverFromRect:sender.frame inView:sender.superview permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        self.popoverProp = infoPopover;
        infoPopover.delegate = self;
        //float superVCHeight = self.view.frame.size.height;
        infoPopover.popoverContentSize = CGSizeMake(450, 350);
    } else {
        [self showVCAsModal:studentInfoTVC];
    }
}

#pragma mark - Additional methods

-(void) assignNextColor {
    CGFloat redFloat = arc4random_uniform(100)/100.f;
    CGFloat greenFloat = arc4random_uniform(100)/100.f;
    CGFloat blueFloat = arc4random_uniform(100)/100.f;
    UIColor* color = [UIColor colorWithRed:redFloat green:greenFloat blue:blueFloat alpha:1.f];
    self.currentColor = color;
}

-(MKAnnotationView*) superAnnotationViewForObject: (UIView*) object {
    if ([object isKindOfClass:[MKAnnotationView class]]) {
        return (MKAnnotationView*) object;
    }
    if (!object.superview) {
        return nil;
    }
    return [self superAnnotationViewForObject:object.superview];
}
-(void) showAlertWithTitle: (NSString*) title andMessage: (NSString*) message {
    [[[UIAlertView alloc] initWithTitle:title
                                message:message
                               delegate:nil
                      cancelButtonTitle:@"Ok"
                      otherButtonTitles:nil] show];
}

//How to draw somethig
-(void) drawCirclesForMeatingPointWithCoordinate: (CLLocationCoordinate2D) coordinate {
//step 1 (create MK-object that assigned on <MKOverlay>)
    MKCircle* circle1 = [MKCircle circleWithCenterCoordinate:coordinate radius:self.radiusForDistZ1];
    MKCircle* circle2 = [MKCircle circleWithCenterCoordinate:coordinate radius:self.radiusForDistZ2];
    MKCircle* circle3 = [MKCircle circleWithCenterCoordinate:coordinate radius:self.radiusForDistZ3];
//step 2 add them to mapview (step 3 look at (-mapView:(MKMapView *)mapView rendererForOverlay:))
    [self.mapView removeOverlays:self.mapView.overlays];
    [self.mapView addOverlays:@[circle1, circle2, circle3] level:MKOverlayLevelAboveLabels];
    //Implement -mapView:rendererForOverlay: on MKMapViewDelegate to return the renderer for each overlay
}

-(void) showViewWithAnalitic {
   
    CGFloat labelHeight = 40;
    CGRect rect = CGRectMake(20, 10, 260, labelHeight*3+10*4);
    UIView* dataView = [[UIView alloc] initWithFrame:rect];
    dataView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.3];
    
    UILabel* labelForDistZ1 = [[UILabel alloc] init];
    labelForDistZ1.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:0.3];
    labelForDistZ1.frame = CGRectMake(20, 10, 220, labelHeight);
    labelForDistZ1.font = [UIFont fontWithName:@"Arial" size:14];
    UILabel* labelForDistZ2 = [[UILabel alloc] init];
    labelForDistZ2.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:0.3];
    labelForDistZ2.frame = CGRectMake(20, labelHeight+10*2, 220, labelHeight);
    labelForDistZ2.font = [UIFont fontWithName:@"Arial" size:14];

    UILabel* labelForDistZ3 = [[UILabel alloc] init];
    labelForDistZ3.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:0.3];
    labelForDistZ3.frame = CGRectMake(20, labelHeight*2+10*3, 220, labelHeight);
    labelForDistZ3.font = [UIFont fontWithName:@"Arial" size:14];

    labelForDistZ1.text = [NSString stringWithFormat:@"number of students in zone 1: %d", self.groupDistanceZone1.count];
    labelForDistZ2.text = [NSString stringWithFormat:@"number of students in zone 2: %d", self.groupDistanceZone2.count];
    labelForDistZ3.text = [NSString stringWithFormat:@"number of students in zone 3: %d", self.groupDistanceZone3.count];
    
    [dataView addSubview:labelForDistZ1];
    [dataView addSubview:labelForDistZ2];
    [dataView addSubview:labelForDistZ3];
    self.viewForAnalitic = dataView;
    [self.mapView addSubview:self.viewForAnalitic];
}
-(void) showViewWhoWillCome {
    
    CGFloat labelHeight = 40;
    CGRect rect = CGRectMake(300, 10, 260, labelHeight*1+10*2);
    UIView* willComeView = [[UIView alloc] initWithFrame:rect];
    willComeView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.3];
    
    UILabel* labelForDistZ1 = [[UILabel alloc] init];
    labelForDistZ1.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:0.3];
    labelForDistZ1.frame = CGRectMake(20, 10, 220, labelHeight);
    labelForDistZ1.font = [UIFont fontWithName:@"Arial" size:14];
    labelForDistZ1.text = [NSString stringWithFormat:@"%d students are coming", self.annotationsForMeeting.count];
    
    [willComeView addSubview:labelForDistZ1];

    self.viewForWhoWillCome = willComeView;
    [self.mapView addSubview:self.viewForWhoWillCome];
}

-(void) calculateDistansesToMeetingPoint {
    if ([self.directions isCalculating]) {
        [self.directions cancel];
    }
    //remove viewWithAnalitic
    if (self.viewForAnalitic) {
        [self.viewForAnalitic removeFromSuperview];
    }
    //purging three arrays of annotations (distanceZones)
    [self.groupDistanceZone1 removeAllObjects];
    [self.groupDistanceZone2 removeAllObjects];
    [self.groupDistanceZone3 removeAllObjects];

    self.isShowedAlertBefore = NO; //nullify indicator for repeating alert-message

    //get only student's annotations
    NSMutableArray* tempArray = [NSMutableArray array];
    for (id <MKAnnotation> annotation in self.mapView.annotations) {
        MapAnnotation* currentAnnotation = (MapAnnotation*) annotation;
        if (currentAnnotation.kindOfAnnotation == annotationKindStudent) {
            [tempArray addObject:annotation];
        }
    }
    self.allStudentsAnnotations = [[NSArray alloc] initWithArray:tempArray];
    
    MKPlacemark* mPointPlacemark = [[MKPlacemark alloc] initWithCoordinate:self.meetingPointCoordinate addressDictionary:nil];
    MKMapItem* mPointMapItem = [[MKMapItem alloc] initWithPlacemark:mPointPlacemark];
    //creating request for every student's annotation
    self.calculationCounter = 0;
    for (MapAnnotation* studentAnnotation in self.allStudentsAnnotations) {
        MKPlacemark* studentPlacemark = [[MKPlacemark alloc] initWithCoordinate:studentAnnotation.coordinate addressDictionary:nil];
        MKMapItem* studentMapItem = [[MKMapItem alloc] initWithPlacemark:studentPlacemark];
        
        MKDirectionsRequest* request =  [[MKDirectionsRequest alloc] init];
        request.source = studentMapItem;
        request.destination = mPointMapItem;
        request.transportType = MKDirectionsTransportTypeAutomobile;
        request.requestsAlternateRoutes = NO;
        
        MKDirections* direction = [[MKDirections alloc] initWithRequest:request];
        
        [direction calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
            if (error && self.isShowedAlertBefore == NO) {
                [self showAlertWithTitle:@"dirrection error" andMessage:error.localizedDescription];
                self.isShowedAlertBefore = YES;
            } else if ([response.routes count] == 0) {
                [self showAlertWithTitle:@"dirrection error" andMessage:[NSString stringWithFormat:@"No routes found for student %@ %@", studentAnnotation.student.firstName, studentAnnotation.student.lastName]];
            } else {
                for (MKRoute* route in response.routes) {
                    studentAnnotation.student.distanceToMeetingPoint = route.distance;
                    //CLLocationDistance currentDistance = route.distance; //just for debugging
                    NSLog(@"Route-distance for next student [%@ %@] was calculated", studentAnnotation.student.firstName, studentAnnotation.student.lastName);
                    if (route.distance < self.radiusForDistZ1) {
                        [self.groupDistanceZone1 addObject:studentAnnotation];
                        studentAnnotation.student.distanceZone = distanceZone1;
                    } else if (route.distance < self.radiusForDistZ2) {
                        [self.groupDistanceZone2 addObject:studentAnnotation];
                        studentAnnotation.student.distanceZone = distanceZone2;
                    } else {
                        [self.groupDistanceZone3 addObject:studentAnnotation];
                        studentAnnotation.student.distanceZone = distanceZone3;
                    }
                }
            }
            self.calculationCounter = self.calculationCounter+1;
            //we display with data about distances ONLY after get last request-response
            if (self.calculationCounter == self.calculationMaxValue) {
                NSLog(@"------> Got last response");
                [self showViewWithAnalitic];
                UIBarButtonItem* makeRoutesButton = [self.navigationItem.rightBarButtonItems objectAtIndex:2];
                makeRoutesButton.enabled = YES;
            }
        }];
    }
    NSLog(@"Exit from holder of calculation-block");
}

#pragma mark - Actions, buttons

-(void) stopCalculations {
    if ([self.directions isCalculating]) {
        [self.directions cancel];
    }
    
    if ([self.geoCoder isGeocoding]) {
        [self.geoCoder cancelGeocode];
    }
}

- (void)tapRecognized:(UITapGestureRecognizer *)recognizer {
    //SS: 1.2 - Using recognizer
    if (self.isAllowedToPick && self.isMeetingPoinExist == NO) {
        CGPoint point;
        if(recognizer.state == UIGestureRecognizerStateRecognized)
        {
            point = [recognizer locationInView:recognizer.view];
        }
        //SS: converting point to coordinates
        CLLocationCoordinate2D location = [self.mapView convertPoint:point toCoordinateFromView:self.mapView];
        MapAnnotation* myAnnotation = [[MapAnnotation alloc] init];
        myAnnotation.kindOfAnnotation = annotationKindMeetingPoint;
        myAnnotation.coordinate = location;
        myAnnotation.title = @"Apointment place";
        [self.mapView addAnnotation:myAnnotation];
        self.isMeetingPoinExist = YES;
        self.meetingPointCoordinate = location; // for creating routes to meeting point
// show/hide buttons
        UIBarButtonItem* setAppointmentButton = [self.navigationItem.rightBarButtonItems objectAtIndex:1];
        UIBarButtonItem* calculDistancesButton = [self.navigationItem.rightBarButtonItems objectAtIndex:3];
        setAppointmentButton.enabled = NO;
        calculDistancesButton.enabled = YES;
    }
}
//SS: switcher for allow/deny adding pin for apointment
-(void) allowPickPoint: (UIBarButtonItem*) sender {
    if (self.isAllowedToPick) {
        self.isAllowedToPick = NO;
        //sender.image = nil;
        sender.tintColor = [UIColor blueColor];
        //sender.title = @"add pin";
    } else {
        self.isAllowedToPick = YES;
        sender.tintColor = [UIColor redColor];
        //sender.title = @"finish";
    }
}

-(void) actionDrawRoutes: (UIBarButtonItem*) sender {
    NSLog(@"actionDrawRoutes");
    
    //remove viewForWhoWillCome
    if (self.viewForWhoWillCome) {
        [self.viewForWhoWillCome removeFromSuperview];
    }
//cleaning all previous overlays, that are MKPolyline, not a MKCircle
    NSMutableArray* trashArray = [NSMutableArray array];
    for (id <MKOverlay> overlay in self.mapView.overlays) {
        if ([overlay isKindOfClass:[MKPolyline class]]) {
            [trashArray addObject:overlay];
        }
    }
    [self.mapView removeOverlays:trashArray];
    
//student's group that included in route-calculation
    self.annotationsForMeeting = [NSMutableArray array];
    for (MapAnnotation* studentAnnotation in self.allStudentsAnnotations) {
        float randValue = arc4random_uniform(100)/100.f;
        //double currentDistance = studentAnnotation.student.distanceToMeetingPoint; //just for debugging
        //NSUInteger currentZone = studentAnnotation.student.distanceZone; //just for debugging
        NSString* names = [NSString stringWithFormat:@"%@ %@", studentAnnotation.student.firstName, studentAnnotation.student.lastName];
    
        if (studentAnnotation.student.distanceZone == distanceZone1 && randValue > 0.2) {
            [self.annotationsForMeeting addObject:studentAnnotation];
            NSLog(@"student %@ from distanceZone1 has ability %.2f and will come", names, randValue);
 
        } else if (studentAnnotation.student.distanceZone == distanceZone2 && randValue > 0.5) {
            [self.annotationsForMeeting addObject:studentAnnotation];
            NSLog(@"student %@ from distanceZone2 has ability %.2f and will come", names, randValue);
            
        } else if (studentAnnotation.student.distanceZone == distanceZone3 && randValue > 0.8) {
            [self.annotationsForMeeting addObject:studentAnnotation];
            NSLog(@"student %@ from distanceZone3 has ability %.2f and will come", names, randValue);
            
        } else {
            NSLog(@"student %@ from has ability %.2f and won't come", names, randValue);
        }
    }
    [self showViewWhoWillCome];
    for (MapAnnotation* ann in self.annotationsForMeeting) {
        
    }

    if ([self.directions isCalculating]) {
        [self.directions cancel];
    }
    
    MKPlacemark* mPointPlacemark = [[MKPlacemark alloc] initWithCoordinate:self.meetingPointCoordinate addressDictionary:nil];
    MKMapItem* mPointMapItem = [[MKMapItem alloc] initWithPlacemark:mPointPlacemark];
    
//take students from array of chosen-for-meeting-students
    for (MapAnnotation* studentAnnotation in self.annotationsForMeeting) {
        MKPlacemark* studentPlacemark = [[MKPlacemark alloc] initWithCoordinate:studentAnnotation.coordinate addressDictionary:nil];
        MKMapItem* studentMapItem = [[MKMapItem alloc] initWithPlacemark:studentPlacemark];
        
        MKDirectionsRequest* request =  [[MKDirectionsRequest alloc] init];
        request.source = studentMapItem;
        request.destination = mPointMapItem;
        request.transportType = MKDirectionsTransportTypeAutomobile;
        request.requestsAlternateRoutes = NO;
        
        MKDirections* direction = [[MKDirections alloc] initWithRequest:request];
        [direction calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
            if (error) {
                [self showAlertWithTitle:@"dirrection error" andMessage:error.localizedDescription];
            } else if ([response.routes count] == 0) {
                [self showAlertWithTitle:@"dirrection error" andMessage:@"No routes found"];
            } else {
                NSMutableArray* polylinesArray = [NSMutableArray array]; //new array for new student-route-request. Because of intention to change color for every student
                for (MKRoute* route in response.routes) {
                    [polylinesArray addObject:route.polyline];
                }
                [self.mapView addOverlays:polylinesArray level:MKOverlayLevelAboveRoads];
                NSLog(@"Route for next student [%@ %@] was added on map", studentAnnotation.student.firstName, studentAnnotation.student.lastName);
                [self assignNextColor]; //changing color for next student-route
            }
        }];
    }
    //Definatly code bellow is executed before block is execute and we get results with overlays, routes and renderes. So it's un-correct to add overlays here.
    NSLog(@"ask for calculating routes for all students is finished");
}

-(void) actionShowAll: (UIBarButtonItem*) sender {
    MKMapRect zoomRect = MKMapRectNull;
    for (id <MKAnnotation> annotNext in self.mapView.annotations) {
        CLLocationCoordinate2D location = annotNext.coordinate;
        MKMapPoint center = MKMapPointForCoordinate(location);
        static double delta = 20000;
        MKMapRect rect = MKMapRectMake(center.x - delta, center.y - delta, delta*2, delta*2);
        zoomRect = MKMapRectUnion(zoomRect, rect); // !!! merging two rect, one-by-one
    }
    zoomRect = [self.mapView mapRectThatFits:zoomRect]; //optimization of certain rect
    [self.mapView setVisibleMapRect:zoomRect edgePadding:UIEdgeInsetsMake(10, 10, 10, 10) animated:YES];
}
-(void) actionStudentInfoFromButton: (UIButton*) sender {
        
    MKAnnotationView* annotationView = [self superAnnotationViewForObject:sender];
    MapAnnotation* certainAnnotation = (MapAnnotation*) annotationView.annotation;
    
    CLLocationCoordinate2D coordinate1 = annotationView.annotation.coordinate;
    CLLocation* location = [[CLLocation alloc] initWithLatitude:coordinate1.latitude longitude:coordinate1.longitude];
    
    if ([self.geoCoder isGeocoding]) {
        [self.geoCoder cancelGeocode];
    }
    //SS: about method bellow. It's not known when we get result of geocoding request, that's why all actions (we need) have to be written IN BLOCK and will be executed later, after getting of result
    [self.geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        NSString* message = nil;
        if (error) {
            message = [error localizedDescription];
            [self showAlertWithTitle:@"Error reverseGeocodeLocation" andMessage:message];
            //NSLog(@"-----> Error reverseGeocodeLocation: \n%@", message);
        } else {
            if ([placemarks count] > 0) {
                MKPlacemark* placeMark = [placemarks firstObject];
                message = [placeMark.addressDictionary description];
                NSArray* addressArray = [placeMark.addressDictionary valueForKey:@"FormattedAddressLines"]; //name of key was found via reading NSLog of [placeMark.addressDictionary description]. Type - ARRAY !!!
                //NSLog(@"addressDictionary description: %@", message);
                NSString* addressString = [addressArray componentsJoinedByString:@"->"];
                [self showInfoTVCForStudent:certainAnnotation.student withAddress:addressString fromButton:sender];
            } else {
                NSLog(@"No placemarks found");
            }
        }
    }];
}

#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        NSLog(@"---->  MKUserLocation annotation is detected");
        return nil;
    }
    static NSString* identifier = @"Annotation";
    MKPinAnnotationView* pin = (MKPinAnnotationView*) [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (!pin) {
        pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
    } else {
        //SS: if pin is re-used, it has old annotation, so we need to replace it on new
        pin.annotation = annotation;
    }
    pin.canShowCallout = YES; //show info-cloud
//assign images for student-annotaion views
    if ([annotation isKindOfClass:[MapAnnotation class]]) {
        MapAnnotation* currentAnnotation = (MapAnnotation*) annotation;
        //Protection to set image and other features only for student's annotations, not for meating-place.
        if (currentAnnotation.kindOfAnnotation == annotationKindStudent) {
            /*if ([self.annotationsForMeeting containsObject:annotation]) {
                //path to make annotationView for students, that are comming on meeting, different. We can set new image
            }*/
            if (currentAnnotation.student.gender) {
                pin.image = [UIImage imageNamed:@"man15.png"];
            } else {
                pin.image = [UIImage imageNamed:@"girl-1.png"];
            }
            UIButton* infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
            [infoButton addTarget:self action:@selector(actionStudentInfoFromButton:) forControlEvents:UIControlEventTouchUpInside];
            pin.rightCalloutAccessoryView = infoButton;
            
        } else if (currentAnnotation.kindOfAnnotation == annotationKindMeetingPoint) {
            //requaires method "didChangeDragState" bellow. And requaires be able to setCoordinate:, it means that protocol-property "coordinate" be not redonly (by default) but assign
            pin.draggable = YES;
            pin.animatesDrop = YES; //falling
            pin.pinColor = MKPinAnnotationColorRed;
            [self drawCirclesForMeatingPointWithCoordinate:annotation.coordinate];
            self.groupDistanceZone1 = [NSMutableArray array];
            self.groupDistanceZone2 = [NSMutableArray array];
            self.groupDistanceZone3 = [NSMutableArray array];
        }
    }
    return pin;
}
//step 3. It's like (-mapView:viewForAnnotation:). You make renderer (like source-tool for drawing) from <MKOverlay> and hang all you need on this renderer
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id <MKOverlay>)overlay {
    
//for meeting-point's circles
    if ([overlay isKindOfClass:[MKCircle class]]) {
        MKCircleRenderer* renderer = [[MKCircleRenderer alloc] initWithOverlay:overlay];
        renderer.lineWidth = 2.f;
        renderer.strokeColor = [UIColor blueColor];
        return renderer;
    }
//for routes from certain students to meeting-point
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolylineRenderer* renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
        renderer.lineWidth = 4.f;
        renderer.strokeColor = self.currentColor;
        renderer.lineDashPhase = 30.f;
        //NSLog(@"new ROUTE-renderer is created");
        return renderer;
    }
    return nil;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view didChangeDragState:(MKAnnotationViewDragState)newState
   fromOldState:(MKAnnotationViewDragState)oldState {
    if (newState == MKAnnotationViewDragStateEnding) {
        CLLocationCoordinate2D newCoordinate = view.annotation.coordinate;
        
        MKMapPoint point = MKMapPointForCoordinate(newCoordinate);
        NSLog(@"\nlocation: %f %f \npoint: %@", newCoordinate.latitude, newCoordinate.longitude, MKStringFromMapPoint(point));
        
        MapAnnotation* currentAnnotation = (MapAnnotation*) view.annotation;
        if (currentAnnotation.kindOfAnnotation == annotationKindMeetingPoint) {
            [self drawCirclesForMeatingPointWithCoordinate:newCoordinate];
            self.meetingPointCoordinate = newCoordinate; // for creating routes to meeting point
            UIBarButtonItem* makeRoutesButton = [self.navigationItem.rightBarButtonItems objectAtIndex:2];
            makeRoutesButton.enabled = NO;
        }
    }
}

# pragma mark - UIPopoverControllerDelegate

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    self.popoverProp = nil;
    //NSLog(@"popoverControllerDidDismissPopover is done");
}

@end
