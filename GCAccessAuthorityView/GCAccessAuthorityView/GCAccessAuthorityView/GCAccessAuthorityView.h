//
//  GCAccessAuthorityView.h
//  GCAccessAuthorityView
//
//  Created by sunflower on 2018/11/8.
//  Copyright © 2018年 sunflower. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    
    GCAccessAuthorityTypeVideoAudio, //视频与麦克风
    
    GCAccessAuthorityTypeVideo,      //视频
    GCAccessAuthorityTypeAudio,      //麦克风
    GCAccessAuthorityTypePhoto,      //相册
    GCAccessAuthorityTypeContacts,   //通讯录
    
} GCAccessAuthorityType;


@interface GCAccessAuthorityView : UIView


/**
 关闭事件block
 */
@property (nonatomic, copy) void(^gc_GCAccessAuthorityViewCloseClick)(void);


/**
 实例化对象并设置需要的权限类型

 @param accessAuthorityType 权限类型
 @return 当前对象
 */
- (instancetype)initWithAccessAuthorityWithType:(GCAccessAuthorityType)accessAuthorityType;


/**
 检查用户权限
 */
- (void)gc_checkAccessAuthorityWithCompletionHandler:(void (^)(BOOL isEnable))handler;

@end
