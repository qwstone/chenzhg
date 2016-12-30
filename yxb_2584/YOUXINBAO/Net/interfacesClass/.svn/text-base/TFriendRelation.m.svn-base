


#import <objc/runtime.h>
#import "TFriendRelation.h"

@implementation TFriendRelation

@dynamic errCode;


//-(void)dealloc
//{
//	self.username = nil;
//	self.friendName = nil;
//	//self.unreadFlag = nil;
//	self.buildTime = nil;
//    self.friendUser = nil;
//    self.errString = nil;
//    
//	[super dealloc];
//}

/***
 
 buildTime = "";
 errString = "\U5bf9\U4e0d\U8d77\Uff0c\U6ca1\U67e5\U5230\U4e24\U8005\U5173\U7cfb!";
 friendId = 0;
 friendName = "";
 friendTUser =
 relationType = 0;
 showFlag = 0;
 "t_id" = "-1";
 unreadFlag = 0;
 userId = 0;
 username = "";
 
 */

-(void) decodeWithDic:(NSDictionary*) dic {
    
    self.t_id = [(NSNumber*)[dic objectForKey:@"t_id"] integerValue];
    self.showFlag = [(NSNumber*)[dic objectForKey:@"showFlag"] integerValue];
    self.buildTime = [dic objectForKey:@"buildTime"];
    self.errString = [dic objectForKey:@"errString"];
    self.friendName = [dic objectForKey:@"friendName"];
    self.username = [dic objectForKey:@"username"];
    self.note = [dic objectForKey:@"note"];
    self.userId = [(NSNumber*)[dic objectForKey:@"userId"] integerValue];
    self.friendId = [(NSNumber*)[dic objectForKey:@"friendId"] integerValue];
    self.relationType = [(NSNumber*)[dic objectForKey:@"relationType"] integerValue];
    self.unreadFlag = [(NSNumber*)[dic objectForKey:@"unreadFlag"] integerValue];
    self.delFlag = [(NSNumber*)[dic objectForKey:@"delFlag"] integerValue];
    self.errCode = [(NSNumber*)[dic objectForKey:@"errCode"] integerValue];
    
    self.friendUser = [[User alloc] init];
    NSDictionary* d = [dic objectForKey:@"friendTUser"];
    [self.friendUser decodeWithDic:d];
    
//    unsigned int propsCount;
//    objc_property_t *props = class_copyPropertyList([self class], &propsCount);
//    for(int i = 0;i < propsCount; i++) {
//        objc_property_t prop = props[i];
//        id value = nil;
//        
//        @try {
//            NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
//            value = [dic objectForKey:propName];
//            if(value != nil) {
//                [self setValue:value forKey:propName];
//            }
//        }
//        @catch (NSException *exception) {
////            [self logError:exception];
//        }
//        
//    }
    
   
}

-(void) decode:(NSString*) str {

    NSError* error = nil;
    NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:&error];
    
    [self decodeWithDic:dic];    
}



@end