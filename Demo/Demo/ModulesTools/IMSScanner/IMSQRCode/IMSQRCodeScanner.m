//
//  IMSQRCodeScanner.m
//  IMSScanner
//
//  Created by 冯君骅 on 2018/5/10.
//  Copyright © 2018年 Aliyun.com. All rights reserved.
//

#import "IMSQRCodeScanner.h"
#import <AVFoundation/AVFoundation.h>

@implementation IMSQRCodeScanner

#pragma mark - 扫描图片二维码

+ (void)scanImage:(UIImage *)image completion:(void(^)(NSArray *values))completion {
	NSAssert(completion, @"回调不能为空");
	
	dispatch_async(dispatch_get_global_queue(0, 0), ^{
		//高精度
		CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy: CIDetectorAccuracyHigh}];
		
		CIImage *ciImage = [[CIImage alloc] initWithImage:image];
		
		NSArray *features = [detector featuresInImage:ciImage];
		
		NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:features.count];
		for (CIQRCodeFeature *feature in features) {
			[arrayM addObject:feature.messageString];
		}
		
		dispatch_async(dispatch_get_main_queue(), ^{
			completion(arrayM.copy);
		});
	});
}

+ (void)qrImageWithString:(NSString *)string completion:(void(^)(UIImage *image))completion {
	NSAssert(completion, @"回调不能为空");
	
	dispatch_async(dispatch_get_global_queue(0, 0), ^{
		
		CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
		
		[qrFilter setDefaults];
		[qrFilter setValue:[string dataUsingEncoding:NSUTF8StringEncoding] forKey:@"inputMessage"];
		
		CIImage *ciImage = qrFilter.outputImage;
		
		CGAffineTransform transform = CGAffineTransformMakeScale(10, 10);
		CIImage *transformedImage = [ciImage imageByApplyingTransform:transform];
		
		CIContext *context = [CIContext contextWithOptions:nil];
		CGImageRef cgImage = [context createCGImage:transformedImage fromRect:transformedImage.extent];
		UIImage *qrImage = [UIImage imageWithCGImage:cgImage scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
		CGImageRelease(cgImage);
		
		dispatch_async(dispatch_get_main_queue(), ^{ completion(qrImage); });
		});
}

@end
