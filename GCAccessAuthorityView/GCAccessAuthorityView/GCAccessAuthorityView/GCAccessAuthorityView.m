//
//  GCAccessAuthorityView.m
//  GCAccessAuthorityView
//
//  Created by sunflower on 2018/11/8.
//  Copyright © 2018年 sunflower. All rights reserved.
//

#import "GCAccessAuthorityView.h"
#import <AVFoundation/AVCaptureDevice.h>
#import <Contacts/Contacts.h>
#import <Photos/PHPhotoLibrary.h>

@interface GCAccessAuthorityView ()

@property (nonatomic, assign) GCAccessAuthorityType accessAuthorityType;

@property (nonatomic, weak) UIView *contentView;


/**
 是否开启了相机权限
 */
@property (nonatomic, assign) BOOL isCarmera;

/**
 是否开启了麦克风权限
 */
@property (nonatomic, assign) BOOL isAuio;


@end

@implementation GCAccessAuthorityView


- (instancetype)initWithAccessAuthorityWithType:(GCAccessAuthorityType)accessAuthorityType{
    self = [super init];
    
    if(self){
        self.accessAuthorityType = accessAuthorityType;
        [self setup];
    }
    return self;
}

- (void)setup{
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    self.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.3];
    
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 30, 60, 60)];
    [closeBtn setImage:[UIImage imageNamed:@"gc_close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
    
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor clearColor];
    contentView.frame = CGRectMake(0, (height-150)/2, width, 150);
    self.contentView  = contentView;
    [self addSubview:contentView];
    
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"拍摄音乐短视频";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:22];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.frame = CGRectMake(0, 0, width, 25);
    [contentView addSubview:titleLabel];
    
    UILabel *infoLabel = [[UILabel alloc] init];
    infoLabel.text = @"允许访问即可进入拍摄";
    infoLabel.textAlignment = NSTextAlignmentCenter;
    infoLabel.font = [UIFont systemFontOfSize:12];
    infoLabel.textColor = [UIColor grayColor];
    infoLabel.frame = CGRectMake(0, CGRectGetMaxY(titleLabel.frame)+10, width, 12);
    [contentView addSubview:infoLabel];
    
    
    UIButton *startCameraBtn = [[UIButton alloc] init];
    startCameraBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [startCameraBtn setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    [startCameraBtn setTitle:@"启用相机访问权限" forState:UIControlStateNormal];
    startCameraBtn.frame = CGRectMake((width-120)/2, CGRectGetMaxY(infoLabel.frame)+50, 120, 20);
    [contentView addSubview:startCameraBtn];
    [startCameraBtn addTarget:self action:@selector(cameraBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *startMicrophoneBtn = [[UIButton alloc] init];
    startMicrophoneBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [startMicrophoneBtn setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    [startMicrophoneBtn setTitle:@"启用麦克风访问权限" forState:UIControlStateNormal];
    startMicrophoneBtn.frame = CGRectMake((width-120)/2, CGRectGetMaxY(startCameraBtn.frame)+30, 120, 20);
    startMicrophoneBtn.hidden = YES;
    [contentView addSubview:startMicrophoneBtn];
    [startMicrophoneBtn addTarget:self action:@selector(cameraBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    if(self.accessAuthorityType == GCAccessAuthorityTypeVideo){
        
    }else if(self.accessAuthorityType == GCAccessAuthorityTypeAudio){
        infoLabel.text = @"允许访问即可语音";
        [startCameraBtn setTitle:@"启用麦克风访问权限" forState:UIControlStateNormal];
        
    }else if (self.accessAuthorityType == GCAccessAuthorityTypePhoto){
        infoLabel.text = @"允许访问即可访问相册";
        [startCameraBtn setTitle:@"启用相册访问权限" forState:UIControlStateNormal];
        
    } else if(self.accessAuthorityType == GCAccessAuthorityTypeContacts){
        infoLabel.text = @"允许访问即可使用通讯录";
        [startCameraBtn setTitle:@"启用通讯录访问权限" forState:UIControlStateNormal];
    
    }else{
        startMicrophoneBtn.hidden = NO;
    }
    
    
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.frame = [UIScreen mainScreen].bounds;
    self.contentView.center = self.center;
}

/**
 根据类型检查用户权限
 */
- (void)gc_checkAccessAuthorityWithCompletionHandler:(void (^)(BOOL isEnable))handler {
    
    
    if(self.accessAuthorityType == GCAccessAuthorityTypeVideoAudio){
        
        [self cameraAuthorityWithAVMediaType:AVMediaTypeVideo completionHandler:^(BOOL isPermit) {
            self.isCarmera = isPermit;
            
            if(handler){
                
                if(self.isCarmera && self.isAuio){
                    handler(YES);
                }else{
                    handler(NO);
                }
                
            }
            
        }];
        
        [self cameraAuthorityWithAVMediaType:AVMediaTypeAudio completionHandler:^(BOOL isPermit) {
            self.isAuio = isPermit;
            
            if(handler){
                
                if(self.isCarmera && self.isAuio){
                    handler(YES);
                }else{
                    handler(NO);
                }
                
            }
            
        }];
        
    }else if (self.accessAuthorityType == GCAccessAuthorityTypeVideo){
        
        [self cameraAuthorityWithAVMediaType:AVMediaTypeVideo completionHandler:^(BOOL isPermit) {
            
            if(handler){
                handler(isPermit);
            }
            
        }];
        
    }else if(self.accessAuthorityType == GCAccessAuthorityTypeAudio){
        
        [self cameraAuthorityWithAVMediaType:AVMediaTypeAudio completionHandler:^(BOOL isPermit) {
            if(handler){
                handler(isPermit);
            }
        }];
        
    }else if(self.accessAuthorityType == GCAccessAuthorityTypePhoto){
        
        [self photoAuthority:^(BOOL isPermit) {
            if(handler){
                handler(isPermit);
            }
            
            if(!isPermit){
                
                //提示
                [self promptWithMeaage:@"未获得照片权限，是否去设置->隐私->照片中授予该权限？"];
            }
            
        }];
        
    }else if(self.accessAuthorityType == GCAccessAuthorityTypeContacts){
        
        [self contactsAuthority:^(BOOL isPermit) {
            if(handler){
                handler(isPermit);
            }
            
            if(!isPermit){
                
                //提示
                [self promptWithMeaage:@"未获得通讯录权限，是否去设置->隐私->通讯录中授予该权限？"];
            }
            
        }];
        
    }
    
    
}

- (void)closeBtnClick{
    
    self.gc_GCAccessAuthorityViewCloseClick();
    
    [self removeFromSuperview];
}

/**
 启用相机点击事件
 */
- (void)cameraBtnClick{
    
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    [[UIApplication sharedApplication] openURL:url];
    
}


/**
 提示
 */
- (void)promptWithMeaage:(NSString *)message{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self cameraBtnClick];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
}


/**
 相机权限 - 麦克风权限
 
 @param handler 是否有权限回调
 
 //AVAuthorizationStatusNotDetermined   系统还未知是否访问，第一次开启相机时
 //AVAuthorizationStatusRestricted      受限制的
 //AVAuthorizationStatusDenied          不允许
 //AVAuthorizationStatusAuthorized      允许状态
 
 */
- (void)cameraAuthorityWithAVMediaType:(AVMediaType)mediaType completionHandler:(void (^)(BOOL isPermit))handler{
    
    //AVMediaTypeAudio  麦克风
    //AVMediaTypeVideo  相机
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    
    switch (authStatus) {
        case AVAuthorizationStatusNotDetermined:
        {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                //切换到主线程
                dispatch_async(dispatch_get_main_queue(), ^{
                    if(granted){
                        //第一次用户允许
                        if(handler){
                            handler(YES);
                        }
                    }else{
                        //第一次用户不允许
                        if(handler){
                            handler(NO);
                        }
                    }
                });
                
            }];
        }
            break;
            
        case AVAuthorizationStatusAuthorized:
            
            if(handler){
                handler(YES);
            }
            
            break;
            
        default:
            if(handler){
                handler(NO);
            }
            break;
    }
    
}

/**
 照片权限
 
 @param handler 回调
 */
- (void)photoAuthority:(void (^)(BOOL isPermit))handler{
    
    PHAuthorizationStatus authorizationStatus = [PHPhotoLibrary authorizationStatus];
    
    switch (authorizationStatus) {
        case PHAuthorizationStatusNotDetermined:
        {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                //切换到主线程
                dispatch_async(dispatch_get_main_queue(), ^{
                    if(status == AVAuthorizationStatusAuthorized){
                        //第一次用户允许
                        if(handler){
                            handler(YES);
                        }
                    }else{
                        //第一次用户不允许
                        if(handler){
                            handler(NO);
                        }
                    }
                });
                
            }];
        }
            break;
            
        case AVAuthorizationStatusAuthorized:
            
            if(handler){
                handler(YES);
            }
            
            break;
            
        default:
            if(handler){
                handler(NO);
            }
            break;
    }
    
}


/**
 通讯录权限

 @param handler 回调
 */
- (void)contactsAuthority:(void (^)(BOOL isPermit))handler{
    
    CNAuthorizationStatus authStatus = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    
    switch (authStatus) {
        case CNAuthorizationStatusNotDetermined:
        {
            
            [[[CNContactStore alloc] init] requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError*  _Nullable error) {
                
                //切换到主线程
                dispatch_async(dispatch_get_main_queue(), ^{
                    if(granted){
                        //第一次用户允许
                        if(handler){
                            handler(YES);
                        }
                    }else{
                        //第一次用户不允许
                        if(handler){
                            handler(NO);
                        }
                    }
                });
                
            }];
            
        }
            break;
            
        case CNAuthorizationStatusAuthorized:
            
            if(handler){
                handler(YES);
            }
            
            break;
            
        default:
            if(handler){
                handler(NO);
            }
            break;
    }
    
}

@end
