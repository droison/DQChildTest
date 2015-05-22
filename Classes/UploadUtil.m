//
//  UploadUtil.m
//  ChildTest
//
//  Created by 淞 柴 on 15/3/19.
//  Copyright (c) 2015年 mumiao. All rights reserved.
//

#import "UploadUtil.h"
#import <QiniuSDK.h>
#import "TestViewController.h"

//#define TOKEN @"1tcwA-6KJ0C4SVODQ2dE2TwsfGfCM5KzlR6Xm-9W:vFPctURC5n4TRsuOg5WO81Y5BJk=:eyJzY29wZSI6ImJpbGxjaGFpYmxvZyIsImRlYWRsaW5lIjoxNDU4MjIzNDQwfQ=="
#define TOKEN @"iWQcG1JWIn2q687MNq3zoLpJsPUPe1dE3E5rhAUb:AC66FoShmB8zCcYmBedamZ7MMuk=:eyJzY29wZSI6ImRxaGQiLCJkZWFkbGluZSI6MTQ2MzIzMTQ0Nn0="
@implementation UploadUtil
#pragma mark - 七牛 upload
- (void)qiniuUpload:(UIImage*)image andName:(NSString*)name
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    float dpi = [userDefaults floatForKey:DRAWDPIKEY];
    
    NSData* data = UIImageJPEGRepresentation(image, dpi ==0? 0.2 : dpi);
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
    NSString* urlString = @"192.168.1.100";
    [self post:image andName:name toIp:urlString];
}

- (void) post:(UIImage*)image andName:(NSString*)name toIp:(NSString*)ip
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    float dpi = [userDefaults floatForKey:DRAWDPIKEY];
    
    NSString* url = [NSString stringWithFormat:@"http://%@/diqiao/admin.php/News/upload", ip];
    //得到图片的data
    NSData* data = UIImageJPEGRepresentation(image, dpi ==0? 0.52 : dpi);
    
    //保存本地
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *libDir = [paths objectAtIndex:0];
    NSString * imageFilePath = [libDir stringByAppendingPathComponent:name];
    [data writeToFile:imageFilePath atomically:YES];
    
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

#define myBoundary  @"*************************--"
- (void) addParam:(NSMutableData*) dataM name:(NSString*) name value:(NSString*)value
{
    [dataM appendData:[[NSString stringWithFormat:@"\n--%@\n",myBoundary] dataUsingEncoding:NSUTF8StringEncoding]];//表示开始
    [dataM appendData:[[NSString stringWithFormat:@"Content-Disposition:form-data;name='%@'\n\n", name] dataUsingEncoding:NSUTF8StringEncoding]];//第一个字段开始，类型于<input type="text" name="user">
    [dataM appendData:[value dataUsingEncoding:NSUTF8StringEncoding]]; //第一个字段的内容，即leve
    [dataM appendData:[[NSString stringWithFormat:@"\n--%@\n",myBoundary]dataUsingEncoding:NSUTF8StringEncoding]];//字段间区分开，也意味着第一个字段结束
}

#pragma mark - 上传文件
- (void)uploadFileWithURL:(NSURL *)url data:(NSData *)data andName:(NSString*)name
{
    // 1> 数据体
    NSString *topStr = [self topStringWithMimeType:@"image/jpeg" uploadFile:name];
    NSString *bottomStr = [self bottomString];
    
    NSMutableData *dataM = [NSMutableData data];
    
    //下面开始增加你的数据了
    //我这里假设表单中，有两个字段，一个叫user,一个叫password
    //字段与字段之间要用到boundary分开
    
    [self addParam:dataM name:@"dq_name" value:_name];
    [self addParam:dataM name:@"dq_phone" value:_phone];
    [self addParam:dataM name:@"dq_age" value:[NSString stringWithFormat:@"%d", _age]];

    [self addParam:dataM name:@"dp_t1" value:@"1"];
    [self addParam:dataM name:@"dp_t2" value:@"1"];
    [self addParam:dataM name:@"dp_t3" value:@"1"];
    [self addParam:dataM name:@"dp_t4" value:@"1"];
    [self addParam:dataM name:@"dp_t5" value:@"1"];
    [self addParam:dataM name:@"dp_t6" value:@"0"];
    [self addParam:dataM name:@"dp_t7" value:@"0"];
    [self addParam:dataM name:@"dp_t8" value:@"1"];
    
    [self addParam:dataM name:@"dp_score" value:@"90"];
    
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
