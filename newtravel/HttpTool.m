//
//  HttpTool.m
//  newtravel
//
//  Created by 王俊钢 on 16/9/30.
//  Copyright © 2016年 wangjungang. All rights reserved.
//

#import "HttpTool.h"
#import "AFNetworking.h"
#import "APIClient.h"

@implementation HttpTool

+ (void)postWithparamsWithURL:(NSString *)url andParam:(NSDictionary *)params success:(Success)success failure:(Failure)failure{
    
    NSString *needURL=[NSString stringWithFormat:@"/TravelerServer/index.php/Home/%@",url];
    
    [[APIClient sharedClient]POST:needURL parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

@end
