//
//  HttpTool.h
//  newtravel
//
//  Created by 王俊钢 on 16/9/30.
//  Copyright © 2016年 wangjungang. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^Success)(id responseObject);
typedef void (^Failure)(NSError *error);
@interface HttpTool : NSObject

+ (void)postWithparamsWithURL:(NSString *)url andParam:(NSDictionary *)params success:(Success)success failure:(Failure)failure;
@end
