////  Hmacmd5AndDescrypt.h//  TestPayEaseAPI////  Created by 陈 斐 on 13-3-11.//  Copyright 2013 PayEase. All rights reserved.//#import <UIKit/UIKit.h>#import <CommonCrypto/CommonCryptor.h>@interface PMCHmacmd5AndDescrypt : NSObject + (id)DES:(NSString*)plainText encryptOrDecrypt:(CCOperation)encryptOrDecrypt key:(NSString*)akey;+ (NSString *)HMACMD5WithKey:(NSString *)akey andData:(NSString *)data;+ (id)rsaEncryptString:(NSString*) string;@end