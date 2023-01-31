#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(HaqqWeb3UtilsRN, NSObject)

RCT_EXTERN_METHOD(
                  generateMnemonic: (NSNumber *) strength
                  resolve: (RCTPromiseResolveBlock) resolve
                  rejecter: (RCTPromiseRejectBlock) reject
                  )

RCT_EXTERN_METHOD(
                  seedFromMnemonic: (NSString *) mnemonicPhrase
                  resolve: (RCTPromiseResolveBlock) resolve
                  rejecter: (RCTPromiseRejectBlock) reject
                  )

RCT_EXTERN_METHOD(
                  derive: (NSString *) seed
                  path: (NSString *) path
                  resolve: (RCTPromiseResolveBlock) resolve
                  rejecter: (RCTPromiseRejectBlock) reject
                  )
RCT_EXTERN_METHOD(
                  accountInfo: (NSString *) privatekey
                  resolve: (RCTPromiseResolveBlock) resolve
                  rejecter: (RCTPromiseRejectBlock) reject
                  )

RCT_EXTERN_METHOD(
                sign: (NSString *) privateKey
                message: (NSString *) message
                resolve: (RCTPromiseResolveBlock) resolve
                rejecter: (RCTPromiseRejectBlock) reject
                )

+ (BOOL)requiresMainQueueSetup
{
  return NO;
}

@end
