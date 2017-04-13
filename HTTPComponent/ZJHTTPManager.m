//
//  ZJHTTPManager.m
//  Pods
//
//  Created by 何助金 on 2017/3/3.
//
//

#import "ZJHTTPManager.h"
static CGFloat kTimeoutInterval = 30;

@implementation ZJHTTPManager
#pragma mark -
+ (ZJHTTPManager *)manager{
    static dispatch_once_t onceToken;
    static ZJHTTPManager *shareManager = nil;
    dispatch_once(&onceToken,^{
        shareManager = [[self alloc]init];
    });
    
    return shareManager;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _sessionManager = [AFHTTPSessionManager manager];
        [_sessionManager setRequestSerializer:[AFJSONRequestSerializer serializer]];
        [_sessionManager.requestSerializer setTimeoutInterval:kTimeoutInterval];
        [_sessionManager.requestSerializer setValue:@"application/jason;form-data;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [_sessionManager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    }
    return self;
}
#pragma mark - RequestMethods

#pragma mark  BaseMethods
/**
 HTTP 异步请求 使用BaseURL
 
 @param resquestType 请求方法 GET POST ...
 @param parameters 请求参数 key-value 格式
 @param success 成功block
 @param failure 失败block
 @return 发起请求是否成功
 */
- (BOOL)resquestWith:(HTTPRequestType)resquestType
          withParams:(nullable id)parameters
             success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
             failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure{
    [self resquestWith:resquestType
               withURL:_baseUrl
            withParams:parameters
               success:success
               failure:failure];
}


/**
 HTTP 异步请求
 
 @param resquestType 请求方法 GET POST ...
 @param strURL       请求地址
 @param parameters 请求参数 key-value 格式
 @param success 成功block
 @param failure 失败block
 @return 发起请求是否成功
 */

- (BOOL)resquestWith:(HTTPRequestType)resquestType
             withURL:(NSString *)strURL
          withParams:(nullable id)parameters
             success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
             failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure{
    
    if(strURL.length<1){
        return NO;
    }
    
    switch (resquestType) {
            case HTTPRequestType_GET:
        {
            [_sessionManager GET:strURL
                      parameters:parameters
                         success:success
                         failure:failure];
        }
            break;
            
            case HTTPRequestType_POST:
        {
            [_sessionManager POST:strURL
                       parameters:parameters
                          success:success
                          failure:failure];
        }
            break;

            case HTTPRequestType_PUT:
        {
            [_sessionManager PUT:strURL
                      parameters:parameters
                         success:success
                         failure:failure];
        }
            break;

            case HTTPRequestType_DELETE:
        {
            [_sessionManager DELETE:strURL
                         parameters:parameters
                            success:success
                            failure:failure];
        }
            break;

            case HTTPRequestType_PATCH:
        {
            [_sessionManager PATCH:strURL
                        parameters:parameters
                           success:success
                            failure:failure];
        }
            break;

        default:
            break;
    }
    
    
    return YES;
}


#pragma mark -  upload
/**
 上传图像
 
 @param imageData 图像Data
 @param strURL 上传路径
 @param parameters 请求参数
 @param uploadProgress 上传进度
 @param success 成功block
 @param failure 失败block
 @return 请求是否发起成功
 */
- (BOOL)uploadImageWithData:(NSData *)imageData
                    withURL:(NSString *)strURL
                 withParams:(nullable id)parameters
                   progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                    success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                    failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    if(strURL.length<1){
        return NO;
    }
 
    [_sessionManager POST:strURL
               parameters:parameters
constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    if (imageData) {
        [formData appendPartWithFileData:imageData
                                    name:@"iamge"
                                fileName:@"image.png"
                                mimeType:@"image/png"];
    }
}
                 progress:uploadProgress
                  success:success failure:failure];
    return YES;
}



/**
 上传自定义文件
 
 @param fileData 文件Data
 @param strURL 上传路径
 @param parameters 请求参数
 @param fileName 文件名
 @param mimeType 文件类型
 @param uploadProgress 上传进度
 @param success 上传成功block
 @param failure 上传失败block
 @return 是否成功发起请求
 */
- (BOOL)uploadFileWithFileData:(NSData *)fileData
                       withURL:(NSString *)strURL
                    withParams:(nullable id)parameters
                  withfileName:(NSString *)fileName
                  withMimeType:(NSString *)mimeType
                      progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    if(strURL.length<1){
        return NO;
    }

    [_sessionManager POST:strURL
               parameters:parameters
constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (fileData) {
            [formData appendPartWithFileData:fileData
                                        name:@"FileContent"
                                    fileName:fileName
                                    mimeType:mimeType];
        }
    }
                 progress:uploadProgress
                  success:success failure:failure];
    return YES;
}
#pragma mark -  download
- (BOOL)dowloadFileWithURL:(NSString *)strURL
                  progress:(void (^)(NSProgress *downloadProgress))
downloadProgressBlock
         completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))complet{

    if(strURL.length<1){
        return NO;
    }
    
    NSURL *url = [NSURL URLWithString:strURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDownloadTask *downloadTask = [_sessionManager downloadTaskWithRequest:request
                                                                             progress:downloadProgressBlock destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory
                                                                              inDomain:NSUserDomainMask
                                                                     appropriateForURL:nil
                                                                                create:NO
                                                                                 error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:complet];
    
    [downloadTask resume];

    return YES;
}
@end
