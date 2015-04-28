//
//  UploadUtil.m
//  ChildTest
//
//  Created by 淞 柴 on 15/3/19.
//  Copyright (c) 2015年 mumiao. All rights reserved.
//

#import "UploadUtil.h"
#import <QiniuSDK.h>

//#define TOKEN @"1tcwA-6KJ0C4SVODQ2dE2TwsfGfCM5KzlR6Xm-9W:vFPctURC5n4TRsuOg5WO81Y5BJk=:eyJzY29wZSI6ImJpbGxjaGFpYmxvZyIsImRlYWRsaW5lIjoxNDU4MjIzNDQwfQ=="
#define TOKEN @"Nl_tSCaEWUQvt73i05hiWxhQn3hHvQPYTXhksnLL:_Ka0WWxUIanPOFm806GIqHO2jVQ=:eyJzY29wZSI6ImRpcWlhbyIsImRlYWRsaW5lIjoxNDYwNTY3ODc2fQ=="
@implementation UploadUtil
#pragma mark - 七牛 upload
- (void)qiniuUpload:(UIImage*)image andName:(NSString*)name
{
    NSData* data = UIImageJPEGRepresentation(image, 0.2);
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    [upManager putData:data key:name token:TOKEN
              complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                  NSLog(@"%@", info);
                  NSLog(@"%@", resp);
              } option:nil];
}

#pragma mark - POST到本地php服务器
- (void) post:(UIImage*)image andName:(NSString*)name
{
    NSString* urlString = @"10.9.181.207";
    [self post:image andName:name toIp:urlString];
}

- (void) post:(UIImage*)image andName:(NSString*)name toIp:(NSString*)ip
{
    NSString* url = [NSString stringWithFormat:@"http://%@/upload.php", ip];
    //得到图片的data
    NSData* data = UIImageJPEGRepresentation(image, 0.2);
    [self uploadFileWithURL:[NSURL URLWithString:url] data:data andName:name];
}

// 拼接字符串
static NSString *boundaryStr = @"--";   // 分隔字符串
static NSString *randomIDStr = @"itcast";          // 本次上传标示字符串
static NSString *uploadID = @"file";              // 上传(php)脚本中，接收文件字段


#pragma mark - 私有方法
- (NSString *)topStringWithMimeType:(NSString *)mimeType uploadFile:(NSString *)uploadFile
{
    NSMutableString *strM = [NSMutableString string];
    
    [strM appendFormat:@"%@%@\n", boundaryStr, randomIDStr];
    [strM appendFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\n", uploadID, uploadFile];
    [strM appendFormat:@"Content-Type: %@\n\n", mimeType];
    
    NSLog(@"%@", strM);
    return [strM copy];
}

- (NSString *)bottomString
{
    NSMutableString *strM = [NSMutableString string];
    
    [strM appendFormat:@"%@%@\n", boundaryStr, randomIDStr];
    [strM appendString:@"Content-Disposition: form-data; name=\"submit\"\n\n"];
    [strM appendString:@"Submit\n"];
    [strM appendFormat:@"%@%@--\n", boundaryStr, randomIDStr];
    
    NSLog(@"%@", strM);
    return [strM copy];
}

#pragma mark - 上传文件
- (void)uploadFileWithURL:(NSURL *)url data:(NSData *)data andName:(NSString*)name
{
    // 1> 数据体
    NSString *topStr = [self topStringWithMimeType:@"image/jpeg" uploadFile:name];
    NSString *bottomStr = [self bottomString];
    
    NSMutableData *dataM = [NSMutableData data];
    [dataM appendData:[topStr dataUsingEncoding:NSUTF8StringEncoding]];
    [dataM appendData:data];
    [dataM appendData:[bottomStr dataUsingEncoding:NSUTF8StringEncoding]];
    
    // 1. Request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:2.0f];
    
    // dataM出了作用域就会被释放,因此不用copy
    request.HTTPBody = dataM;
    
    // 2> 设置Request的头属性
    request.HTTPMethod = @"POST";
    
    // 3> 设置Content-Length
    NSString *strLength = [NSString stringWithFormat:@"%ld", (long)dataM.length];
    [request setValue:strLength forHTTPHeaderField:@"Content-Length"];
    
    // 4> 设置Content-Type
    NSString *strContentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", randomIDStr];
    [request setValue:strContentType forHTTPHeaderField:@"Content-Type"];
    
    // 3> 连接服务器发送请求
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@", result);
    }];
}
@end
