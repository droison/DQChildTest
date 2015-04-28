//
//  UploadUtil.h
//  ChildTest
//
//  Created by 淞 柴 on 15/3/19.
//  Copyright (c) 2015年 mumiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UploadUtil : NSObject

- (void) qiniuUpload:(UIImage*)image andName:(NSString*)name;
- (void) post:(UIImage*)image andName:(NSString*)name;
- (void) post:(UIImage*)image andName:(NSString*)name toIp:(NSString*)url;
@end
