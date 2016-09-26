//
//  tripnavViewController.h
//  newtravel
//
//  Created by 王俊钢 on 16/9/22.
//  Copyright © 2016年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
@interface tripnavViewController : UIViewController<BMKMapViewDelegate, BMKRouteSearchDelegate>

@end
