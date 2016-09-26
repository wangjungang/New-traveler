//
//  tripnavViewController.m
//  newtravel
//
//  Created by 王俊钢 on 16/9/22.
//  Copyright © 2016年 wangjungang. All rights reserved.
//

#import "tripnavViewController.h"
#import "Masonry.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件
#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件
#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import "MBProgressHUD+XMG.h"
#define MYBUNDLE_NAME @ "mapapi.bundle"
#define MYBUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: MYBUNDLE_NAME]
#define MYBUNDLE [NSBundle bundleWithPath: MYBUNDLE_PATH]
@interface tripnavViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,UITextFieldDelegate>

{
    BMKLocationService* _locService;
    BMKMapView *mapView;
    CLLocationCoordinate2D coordinate;
    
    BMKRouteSearch* _routesearch;
    
    BOOL isequal;
}
@property (nonatomic,strong) UITextField *startCityText;
@property (nonatomic,strong) UITextField *startAddText;
@property (nonatomic,strong) UITextField *endCityText;
@property (nonatomic,strong) UITextField *endAddrText;
@property (nonatomic,strong) UIButton *walkbtn;
@property (nonatomic,strong) UIButton *ridebtn;
@property (nonatomic,strong) UIButton *drivebtn;
@property (nonatomic,strong) UIButton *busbtn;
@property (nonatomic,strong) UIButton *cancelbtn;

@property (nonatomic,strong) UILabel *startCityLabel;
@property (nonatomic,strong) UILabel *startAddLabel;
@property (nonatomic,strong) UILabel *endCityLabel;
@property (nonatomic,strong) UILabel *endAddLabel;

@end

@interface RouteAnnotation : BMKPointAnnotation
{
    int _type; ///<0:起点 1：终点 2：公交 3：地铁 4:驾乘 5:途经点
    int _degree;
}
@property (nonatomic) int type;
@property (nonatomic) int degree;
@end


@implementation RouteAnnotation

@synthesize type = _type;
@synthesize degree = _degree;
@end
@implementation tripnavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:
    @{NSFontAttributeName:[UIFont systemFontOfSize:19],
      NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.title = @"行程导航";
    isequal = YES;

    
    
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(textremove)];
    [self.view addGestureRecognizer:singleTap1];
    
    mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 64+60, UIScreenWidth, UIScreenWidth)];
    [self.view addSubview:mapView];
//
    mapView.delegate = self;                            //设置代理
    mapView.showsUserLocation = YES;                //设置为可以显示用户位置
    // CLLocationCoordinate2D coordinate;                  //设定经纬度
    //coordinate.latitude = 40.027283;                    //经度
    //coordinate.longitude = 116.313217;                  //纬度

    _routesearch = [[BMKRouteSearch alloc]init];
    
    
    BMKLocationService *locationService = [[BMKLocationService alloc]init];
    locationService.delegate=self;
    [locationService startUserLocationService];
//    [mapView setShowsUserLocation:NO];
    mapView.userTrackingMode=BMKUserTrackingModeFollow;//地图模式
    [mapView setShowsUserLocation:YES];//显示定位的蓝点儿
    
    [mapView setMapType:BMKMapTypeStandard];//地图模式为普通地图
    
    
    BMKCoordinateRegion viewRegion = BMKCoordinateRegionMake(coordinate, BMKCoordinateSpanMake(1.0,1.0));
    BMKCoordinateRegion adjustedRegion = [mapView regionThatFits:viewRegion];
    [mapView setRegion:adjustedRegion animated:YES];

    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.navigationController.navigationBar.translucent = YES;
    }
    _locService = [[BMKLocationService alloc]init];
    
    [self follow];
    [self Click];
    
    
    UIBarButtonItem* btnWayPoint = [[UIBarButtonItem alloc]init];
    btnWayPoint.target = self;
    btnWayPoint.action = @selector(qiehuan);
    btnWayPoint.title = @"切换";
    btnWayPoint.enabled=TRUE;
    self.navigationController.topViewController.navigationItem.rightBarButtonItem = btnWayPoint;
    
    [self.view addSubview:self.startCityText];
    [self.view addSubview:self.startAddText];
    [self.view addSubview:self.endCityText];
    [self.view addSubview:self.endAddrText];
    
    [self.view addSubview:self.walkbtn];
    [self.view addSubview:self.ridebtn];
    [self.view addSubview:self.busbtn];
    [self.view addSubview:self.drivebtn];
    
    [self.view addSubview:self.cancelbtn];
    
    [self.view addSubview:self.startCityLabel];
    [self.view addSubview:self.startAddLabel];
    [self.view addSubview:self.endCityLabel];
    [self.view addSubview:self.endAddLabel];
}

#pragma mark - getters

-(UITextField *)startCityText
{
    if(!_startCityText)
    {
        _startCityText = [[UITextField alloc] init];
        _startCityText.delegate = self;
        _startCityText.text = @"北京";
        _startCityText.backgroundColor = UIColorFromRGB(0X27A18E);
    }
    return _startCityText;
}

-(UITextField *)startAddText
{
    if(!_startAddText)
    {
        _startAddText = [[UITextField alloc] init];
        _startAddText.delegate = self;
        _startAddText.text = @"天安门";
        _startAddText.backgroundColor = UIColorFromRGB(0X27A18E);
    }
    return _startAddText;
}

-(UITextField *)endCityText
{
    if(!_endCityText)
    {
        _endCityText = [[UITextField alloc] init];
        _endCityText.delegate = self;
        _endCityText.text = @"北京";
        _endCityText.backgroundColor = UIColorFromRGB(0X27A18E);
    }
    return _endCityText;
}

-(UITextField *)endAddrText
{
    if(!_endAddrText)
    {
        _endAddrText = [[UITextField alloc] init];
        _endAddrText.delegate = self;
        _endAddrText.text = @"百度大厦";
        _endAddrText.backgroundColor = UIColorFromRGB(0X27A18E);
    }
    return _endAddrText;
}

-(UIButton *)walkbtn
{
    if(!_walkbtn)
    {
        _walkbtn = [[UIButton alloc] init];
        [_walkbtn addTarget:self action:@selector(onClickWalkSearch) forControlEvents:UIControlEventTouchUpInside];
        _walkbtn.backgroundColor = UIColorFromRGB(0X27A18E);
        [_walkbtn setImage:[UIImage imageNamed:@"人行图标"] forState:UIControlStateNormal];
    }
    return _walkbtn;
}

-(UIButton *)busbtn
{
    if(!_busbtn)
    {
        _busbtn = [[UIButton alloc] init];
        [_busbtn addTarget:self action:@selector(onClickBusSearch) forControlEvents:UIControlEventTouchUpInside];
        _busbtn.backgroundColor = UIColorFromRGB(0X27A18E);
        [_busbtn setImage:[UIImage imageNamed:@"地铁"] forState:UIControlStateNormal];
    }
    return _busbtn;
}

-(UIButton *)drivebtn
{
    if(!_drivebtn)
    {
        _drivebtn = [[UIButton alloc] init];
        [_drivebtn addTarget:self action:@selector(onClickDriveSearch) forControlEvents:UIControlEventTouchUpInside];
        _drivebtn.backgroundColor = UIColorFromRGB(0X27A18E);
        [_drivebtn setImage:[UIImage imageNamed:@"汽车图标"] forState:UIControlStateNormal];
    }
    return _drivebtn;
}

-(UIButton *)ridebtn
{
    if(!_ridebtn)
    {
        _ridebtn = [[UIButton alloc] init];
        _ridebtn.backgroundColor = UIColorFromRGB(0X27A18E);
        [_ridebtn setImage:[UIImage imageNamed:@"自行车图标"] forState:UIControlStateNormal];
        [_ridebtn addTarget:self action:@selector(onClickRidingSearch:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _ridebtn;
}

-(UIButton *)cancelbtn
{
    if(!_cancelbtn)
    {
        _cancelbtn = [[UIButton alloc] init];
        _cancelbtn.backgroundColor = UIColorFromRGB(0X27A18E);
        [_cancelbtn addTarget:self action:@selector(cancelbtnclick) forControlEvents:UIControlEventTouchUpInside];
        [_cancelbtn setTitle:@"取消导航" forState:UIControlStateNormal];
        _cancelbtn.layer.masksToBounds = YES;
        _cancelbtn.layer.cornerRadius = 8;
    }
    return _cancelbtn;
}


-(void)viewWillAppear:(BOOL)animated {
    [mapView viewWillAppear];
     mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;
    _routesearch.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放

    self.startCityText.frame = CGRectMake(10, 64, 80, 50);
    self.startAddText.frame = CGRectMake(100, 64, 80, 50);
    self.endCityText.frame = CGRectMake(200, 64, 80, 50);
    self.endAddrText.frame = CGRectMake(300, 64, 80, 50);
    
    
    self.walkbtn.frame = CGRectMake(20, UIScreenHeight-160, UIScreenWidth/4-20 , 50);
    self.drivebtn.frame = CGRectMake(UIScreenWidth/4-10+20, UIScreenHeight-160, UIScreenWidth/4-20, 50);
    self.ridebtn.frame = CGRectMake(UIScreenWidth/2, UIScreenHeight-160, UIScreenWidth/4-20, 50);
    self.busbtn.frame = CGRectMake(UIScreenWidth/4-10+UIScreenWidth/2, UIScreenHeight-160, UIScreenWidth/4-20, 50);
    
    self.cancelbtn.frame = CGRectMake(40, UIScreenHeight-98, UIScreenWidth-80, 35);
}

-(void)viewWillDisappear:(BOOL)animated {
    [mapView viewWillDisappear];
    mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
    _routesearch.delegate = nil; // 不用时，置nil
    
}

-(void)Click
{   NSLog(@"进入罗盘态");
    [_locService startUserLocationService];
    mapView.showsUserLocation = NO;//先关闭显示的定位图层
    mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    mapView.showsUserLocation = YES;//显示定位图层

    mapView.userTrackingMode = BMKUserTrackingModeFollowWithHeading;
    
    [mapView setZoomEnabled:YES];
    [mapView setZoomLevel:16];//级别，3-19
    mapView.showMapScaleBar = YES;//比例尺
    mapView.mapScaleBarPosition = CGPointMake(10,mapView.frame.size.height-45);//比例尺的位置

}

//切换视图
-(void)qiehuan
{
    NSLog(@"切换视图");
    isequal = !isequal;
    if (isequal==YES) {
        [mapView setMapType:BMKMapTypeStandard];//地图模式为标准地图

    }
        else
        {
            [mapView setMapType:BMKMapTypeSatellite];//地图模式为标准地图

        }
}

-(void)follow
{
    NSLog(@"进入跟随态");
    
   // mapView.showsUserLocation = NO;
    mapView.userTrackingMode = BMKUserTrackingModeFollow;
    mapView.showsUserLocation = YES;
    
//    
//    [mapView setZoomEnabled:YES];
//    [mapView setZoomLevel:16];//级别，3-19
//    mapView.showMapScaleBar = YES;//比例尺
//    mapView.mapScaleBarPosition = CGPointMake(10,mapView.frame.size.height-45);//比例尺的位置

}

- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [mapView updateLocationData:userLocation];
    NSLog(@"heading is %@",userLocation.heading);
    
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [mapView updateLocationData:userLocation];
}

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)didStopLocatingUser
{
    NSLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//- (void)dealloc {
//    if (_routesearch != nil) {
//        _routesearch = nil;
//    }
//    if (mapView) {
//        mapView = nil;
//    }
//}

#pragma mark - BMKMapViewDelegate

- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[RouteAnnotation class]]) {
        return [self getRouteAnnotationView:view viewForAnnotation:(RouteAnnotation*)annotation];
    }
    return nil;
}

- (BMKOverlayView*)mapView:(BMKMapView *)map viewForOverlay:(id<BMKOverlay>)overlay
{
    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.fillColor = [[UIColor alloc] initWithRed:0 green:1 blue:1 alpha:1];
        polylineView.strokeColor = [[UIColor alloc] initWithRed:0 green:0 blue:1 alpha:0.7];
        polylineView.lineWidth = 3.0;
        return polylineView;
    }
    return nil;
}

#pragma mark - BMKRouteSearchDelegate

- (void)onGetTransitRouteResult:(BMKRouteSearch*)searcher result:(BMKTransitRouteResult*)result errorCode:(BMKSearchErrorCode)error
{
    NSArray* array =
    [NSArray arrayWithArray:mapView.annotations];
    [mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:mapView.overlays];
    [mapView removeOverlays:array];
    if (error==BMK_SEARCH_AMBIGUOUS_ROURE_ADDR) {
        NSLog(@"重新搜索");
        [MBProgressHUD showError:@"请重新输入地址"];
    }
    if (error == BMK_SEARCH_NO_ERROR) {
        BMKTransitRouteLine* plan = (BMKTransitRouteLine*)[result.routes objectAtIndex:0];
        // 计算路线方案中的路段数目
        
        
        NSInteger size = [plan.steps count];
        int planPointCounts = 0;
        for (int i = 0; i < size; i++) {
            BMKTransitStep* transitStep = [plan.steps objectAtIndex:i];
            if(i==0){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
     
                item.coordinate = plan.starting.location;
                item.title = @"起点";
                item.type = 0;
                [mapView addAnnotation:item]; // 添加起点标注
                
            }else if(i==size-1){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.terminal.location;
                item.title = @"终点";
                item.type = 1;
                [mapView addAnnotation:item]; // 添加起点标注
            }
            RouteAnnotation* item = [[RouteAnnotation alloc]init];
            item.coordinate = transitStep.entrace.location;
            item.title = transitStep.instruction;
            item.type = 3;
            [mapView addAnnotation:item];
            
            //轨迹点总数累计
            planPointCounts += transitStep.pointsCount;
        }
        
        //轨迹点
        BMKMapPoint * temppoints = new BMKMapPoint[planPointCounts];
        int i = 0;
        for (int j = 0; j < size; j++) {
            BMKTransitStep* transitStep = [plan.steps objectAtIndex:j];
            int k=0;
            for(k=0;k<transitStep.pointsCount;k++) {
                temppoints[i].x = transitStep.points[k].x;
                temppoints[i].y = transitStep.points[k].y;
                i++;
            }
            
        }
        // 通过points构建BMKPolyline
        BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:temppoints count:planPointCounts];
        [mapView addOverlay:polyLine]; // 添加路线overlay
        delete []temppoints;
        [self mapViewFitPolyLine:polyLine];
    }
}

- (void)onGetDrivingRouteResult:(BMKRouteSearch*)searcher result:(BMKDrivingRouteResult*)result errorCode:(BMKSearchErrorCode)error
{
    NSArray* array = [NSArray arrayWithArray:mapView.annotations];
    [mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:mapView.overlays];
    [mapView removeOverlays:array];
    if (error==BMK_SEARCH_AMBIGUOUS_ROURE_ADDR) {
        NSLog(@"重新搜索");
        [MBProgressHUD showError:@"请重新输入地址"];
    }
    if (error == BMK_SEARCH_NO_ERROR) {
        BMKDrivingRouteLine* plan = (BMKDrivingRouteLine*)[result.routes objectAtIndex:0];
        // 计算路线方案中的路段数目
        NSInteger size = [plan.steps count];
        int planPointCounts = 0;
        for (int i = 0; i < size; i++) {
            BMKDrivingStep* transitStep = [plan.steps objectAtIndex:i];
            if(i==0){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.starting.location;
                item.title = @"起点";
                item.type = 0;
                [mapView addAnnotation:item]; // 添加起点标注
                
            }else if(i==size-1){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.terminal.location;
                item.title = @"终点";
                item.type = 1;
                [mapView addAnnotation:item]; // 添加起点标注
            }
            //添加annotation节点
            RouteAnnotation* item = [[RouteAnnotation alloc]init];
            item.coordinate = transitStep.entrace.location;
            item.title = transitStep.entraceInstruction;
            item.degree = transitStep.direction * 30;
            item.type = 4;
            [mapView addAnnotation:item];
            
            //轨迹点总数累计
            planPointCounts += transitStep.pointsCount;
        }
        // 添加途经点
        if (plan.wayPoints) {
            for (BMKPlanNode* tempNode in plan.wayPoints) {
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item = [[RouteAnnotation alloc]init];
                item.coordinate = tempNode.pt;
                item.type = 5;
                item.title = tempNode.name;
                [mapView addAnnotation:item];
            }
        }
        //轨迹点
        BMKMapPoint * temppoints = new BMKMapPoint[planPointCounts];
        int i = 0;
        for (int j = 0; j < size; j++) {
            BMKDrivingStep* transitStep = [plan.steps objectAtIndex:j];
            int k=0;
            for(k=0;k<transitStep.pointsCount;k++) {
                temppoints[i].x = transitStep.points[k].x;
                temppoints[i].y = transitStep.points[k].y;
                i++;
            }
            
        }
        // 通过points构建BMKPolyline
        BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:temppoints count:planPointCounts];
        [mapView addOverlay:polyLine]; // 添加路线overlay
        delete []temppoints;
        [self mapViewFitPolyLine:polyLine];
    }
}

- (void)onGetWalkingRouteResult:(BMKRouteSearch*)searcher result:(BMKWalkingRouteResult*)result errorCode:(BMKSearchErrorCode)error
{
    NSArray* array = [NSArray arrayWithArray:mapView.annotations];
    [mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:mapView.overlays];
    [mapView
     
     
     removeOverlays:array];
    if (error==BMK_SEARCH_AMBIGUOUS_ROURE_ADDR) {
        NSLog(@"重新搜索");
        [MBProgressHUD showError:@"请重新输入地址"];
    }
    if (error == BMK_SEARCH_NO_ERROR) {
        BMKWalkingRouteLine* plan = (BMKWalkingRouteLine*)[result.routes objectAtIndex:0];
        NSInteger size = [plan.steps count];
        int planPointCounts = 0;
        for (int i = 0; i < size; i++) {
            BMKWalkingStep* transitStep = [plan.steps objectAtIndex:i];
            if(i==0){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.starting.location;
                item.title = @"起点";
                item.type = 0;
                [mapView addAnnotation:item]; // 添加起点标注
                
            }else if(i==size-1){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.terminal.location;
                item.title = @"终点";
                item.type = 1;
                [mapView addAnnotation:item]; // 添加起点标注
            }
            //添加annotation节点
            RouteAnnotation* item = [[RouteAnnotation alloc]init];
            item.coordinate = transitStep.entrace.location;
            item.title = transitStep.entraceInstruction;
            item.degree = transitStep.direction * 30;
            item.type = 4;
            [mapView addAnnotation:item];
            
            //轨迹点总数累计
            planPointCounts += transitStep.pointsCount;
        }
        
        //轨迹点
        BMKMapPoint * temppoints = new BMKMapPoint[planPointCounts];
        int i = 0;
        for (int j = 0; j < size; j++) {
            BMKWalkingStep* transitStep = [plan.steps objectAtIndex:j];
            int k=0;
            for(k=0;k<transitStep.pointsCount;k++) {
                temppoints[i].x = transitStep.points[k].x;
                temppoints[i].y = transitStep.points[k].y;
                i++;
            }
            
        }
        // 通过points构建BMKPolyline
        BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:temppoints count:planPointCounts];
        [mapView addOverlay:polyLine]; // 添加路线overlay
        delete []temppoints;
        [self mapViewFitPolyLine:polyLine];
    }
}

/**
 *返回骑行搜索结果
 *@param searcher 搜索对象
 *@param result 搜索结果，类型为BMKRidingRouteResult
 *@param error 错误号，@see BMKSearchErrorCode
 */
- (void)onGetRidingRouteResult:(BMKRouteSearch *)searcher result:(BMKRidingRouteResult *)result errorCode:(BMKSearchErrorCode)error {
    NSLog(@"onGetRidingRouteResult error:%d", (int)error);
    NSArray* array = [NSArray arrayWithArray:mapView.annotations];
    [mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:mapView.overlays];
    [mapView removeOverlays:array];
    if (error==BMK_SEARCH_AMBIGUOUS_ROURE_ADDR) {
        NSLog(@"重新搜索");
        [MBProgressHUD showError:@"请重新输入地址"];
    }
    if (error == BMK_SEARCH_NO_ERROR) {
        BMKRidingRouteLine* plan = (BMKRidingRouteLine*)[result.routes objectAtIndex:0];
        NSInteger size = [plan.steps count];
        int planPointCounts = 0;
        for (int i = 0; i < size; i++) {
            BMKRidingStep* transitStep = [plan.steps objectAtIndex:i];
            if (i == 0) {
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.starting.location;
                item.title = @"起点";
                item.type = 0;
                [mapView addAnnotation:item]; // 添加起点标注
            } else if(i==size-1){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.terminal.location;
                item.title = @"终点";
                item.type = 1;
                [mapView addAnnotation:item]; // 添加起点标注
            }
            //添加annotation节点
            RouteAnnotation* item = [[RouteAnnotation alloc]init];
            item.coordinate = transitStep.entrace.location;
            item.title = transitStep.instruction;
            item.degree = (int)transitStep.direction * 30;
            item.type = 4;
            [mapView addAnnotation:item];
            
            //轨迹点总数累计
            planPointCounts += transitStep.pointsCount;
        }
        
        //轨迹点
        BMKMapPoint * temppoints = new BMKMapPoint[planPointCounts];
        int i = 0;
        for (int j = 0; j < size; j++) {
            BMKRidingStep* transitStep = [plan.steps objectAtIndex:j];
            int k=0;
            for(k=0;k<transitStep.pointsCount;k++) {
                temppoints[i].x = transitStep.points[k].x;
                temppoints[i].y = transitStep.points[k].y;
                i++;
            }
            
        }
        // 通过points构建BMKPolyline
        BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:temppoints count:planPointCounts];
        [mapView addOverlay:polyLine]; // 添加路线overlay
        delete []temppoints;
        [self mapViewFitPolyLine:polyLine];
    }
}

#pragma mark - action
//公交车
-(void)onClickBusSearch
{
    BMKPlanNode* start = [[BMKPlanNode alloc]init];
    start.name = _startAddText.text;
    BMKPlanNode* end = [[BMKPlanNode alloc]init];
    end.name = _endAddrText.text;
    
    BMKTransitRoutePlanOption *transitRouteSearchOption = [[BMKTransitRoutePlanOption alloc]init];
//    transitRouteSearchOption.city= @"北京市";
    transitRouteSearchOption.city= self.startCityText.text;
    transitRouteSearchOption.from = start;
    transitRouteSearchOption.to = end;
    BOOL flag = [_routesearch transitSearch:transitRouteSearchOption];
    
    if(flag)
    {
        NSLog(@"bus检索发送成功");
         mapView.showsUserLocation = NO;
    }
    else
    {
        NSLog(@"bus检索发送失败");
    }
}

-(IBAction)textFiledReturnEditing:(id)sender {
    [sender resignFirstResponder];
}
//开车
-(void)onClickDriveSearch
{
    BMKPlanNode* start = [[BMKPlanNode alloc]init];
    start.name = _startAddText.text;
    start.cityName = self.startCityText.text;
    BMKPlanNode* end = [[BMKPlanNode alloc]init];
    end.name = _endAddrText.text;
    end.cityName = self.endCityText.text;
    
    BMKDrivingRoutePlanOption *drivingRouteSearchOption = [[BMKDrivingRoutePlanOption alloc]init];
    drivingRouteSearchOption.from = start;
    drivingRouteSearchOption.to = end;
    drivingRouteSearchOption.drivingRequestTrafficType = BMK_DRIVING_REQUEST_TRAFFICE_TYPE_NONE;//不获取路况信息
    BOOL flag = [_routesearch drivingSearch:drivingRouteSearchOption];
    if(flag)
    {
        NSLog(@"car检索发送成功");
         mapView.showsUserLocation = NO;
    }
    else
    {
        NSLog(@"car检索发送失败");
    }
    
}
//步行
-(void)onClickWalkSearch
{
    BMKPlanNode* start = [[BMKPlanNode alloc]init];
    start.name = self.startAddText.text;
    start.cityName = self.startCityText.text;
    BMKPlanNode* end = [[BMKPlanNode alloc]init];
    end.name = self.endAddrText.text;
    end.cityName = self.endCityText.text;
    

    BMKWalkingRoutePlanOption *walkingRouteSearchOption = [[BMKWalkingRoutePlanOption alloc]init];
    walkingRouteSearchOption.from = start;
    walkingRouteSearchOption.to = end;
    BOOL flag = [_routesearch walkingSearch:walkingRouteSearchOption];
    if(flag)
    {
        NSLog(@"walk检索发送成功");
         mapView.showsUserLocation = NO;
    }
    else
    {
        NSLog(@"walk检索发送失败");
    }
    
}

//骑车

- (void)onClickRidingSearch:(id)sender {
    BMKPlanNode* start = [[BMKPlanNode alloc]init];
    start.name = _startAddText.text;
    start.cityName = self.startCityText.text;
    BMKPlanNode* end = [[BMKPlanNode alloc]init];
    end.name = _endAddrText.text;
    end.cityName = self.endCityText.text;
    
    BMKRidingRoutePlanOption *option = [[BMKRidingRoutePlanOption alloc]init];
    option.from = start;
    option.to = end;
    BOOL flag = [_routesearch ridingSearch:option];
    if (flag)
    {
        NSLog(@"骑行规划检索发送成功");
         mapView.showsUserLocation = NO;
    }
    else
    {
        NSLog(@"骑行规划检索发送失败");
    }
}

#pragma mark - 私有

- (NSString*)getMyBundlePath1:(NSString *)filename
{
    
    NSBundle * libBundle = MYBUNDLE ;
    if ( libBundle && filename ){
        NSString * s=[[libBundle resourcePath ] stringByAppendingPathComponent : filename];
        return s;
    }
    return nil ;
}

- (BMKAnnotationView*)getRouteAnnotationView:(BMKMapView *)mapview viewForAnnotation:(RouteAnnotation*)routeAnnotation
{
    BMKAnnotationView* view = nil;
    switch (routeAnnotation.type) {
        case 0:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"start_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"start_node"];
                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_start.png"]];
                view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
                view.canShowCallout = TRUE;
            }
            view.annotation = routeAnnotation;
        }
            break;
        case 1:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"end_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"end_node"];
                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_end.png"]];
                view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
                view.canShowCallout = TRUE;
            }
            view.annotation = routeAnnotation;
        }
            break;
        case 2:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"bus_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"bus_node"];
                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_bus.png"]];
                view.canShowCallout = TRUE;
            }
            view.annotation = routeAnnotation;
        }
            break;
        case 3:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"rail_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"rail_node"];
                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_rail.png"]];
                view.canShowCallout = TRUE;
            }
            view.annotation = routeAnnotation;
        }
            break;
        case 4:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"route_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"route_node"];
                view.canShowCallout = TRUE;
            } else {
                [view setNeedsDisplay];
            }
            
            UIImage* image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_direction.png"]];
           // view.image = [image imageRotatedByDegrees:routeAnnotation.degree];
            view.annotation = routeAnnotation;
            
        }
            break;
        case 5:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"waypoint_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"waypoint_node"];
                view.canShowCallout = TRUE;
            } else {
                [view setNeedsDisplay];
            }
            
            UIImage* image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_waypoint.png"]];
           // view.image = [image imageRotatedByDegrees:routeAnnotation.degree];
            view.annotation = routeAnnotation;
        }
            break;
        default:
            break;
    }
    
    return view;
}

//根据polyline设置地图范围
- (void)mapViewFitPolyLine:(BMKPolyline *) polyLine {
    CGFloat ltX, ltY, rbX, rbY;
    if (polyLine.pointCount < 1) {
        return;
    }
    BMKMapPoint pt = polyLine.points[0];
    ltX = pt.x, ltY = pt.y;
    rbX = pt.x, rbY = pt.y;
    for (int i = 1; i < polyLine.pointCount; i++) {
        BMKMapPoint pt = polyLine.points[i];
        if (pt.x < ltX) {
            ltX = pt.x;
        }
        if (pt.x > rbX) {
            rbX = pt.x;
        }
        if (pt.y > ltY) {
            ltY = pt.y;
        }
        if (pt.y < rbY) {
            rbY = pt.y;
        }
    }
    BMKMapRect rect;
    rect.origin = BMKMapPointMake(ltX , ltY);
    rect.size = BMKMapSizeMake(rbX - ltX, rbY - ltY);
    [mapView setVisibleMapRect:rect];
    mapView.zoomLevel = mapView.zoomLevel - 0.3;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    return YES;
}

-(void)textremove
{
    [self.startCityText resignFirstResponder];
    [self.startAddText resignFirstResponder];
    [self.endCityText resignFirstResponder];
    [self.endAddrText resignFirstResponder];
}

#pragma mark - 取消导航
-(void)cancelbtnclick
{
    [mapView setShowsUserLocation:YES];//显示定位的蓝点儿
}

@end
