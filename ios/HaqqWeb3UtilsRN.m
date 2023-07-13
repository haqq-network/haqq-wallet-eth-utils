#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(HaqqWeb3UtilsRN, NSObject)

RCT_EXTERN_METHOD(
                  generateEntropy: (nonnull NSNumber) strength
                  resolve: (RCTPromiseResolveBlock) resolve
                  rejecter: (RCTPromiseRejectBlock) reject
                  )

RCT_EXTERN_METHOD(
                  generateMnemonicFromEntropy: (nonnull NSString) entropy
                  resolve: (RCTPromiseResolveBlock) resolve
                  rejecter: (RCTPromiseRejectBlock) reject
                  )

RCT_EXTERN_METHOD(
                  generateMnemonic: (nonnull NSNumber) strength
                  resolve: (RCTPromiseResolveBlock) resolve
                  rejecter: (RCTPromiseRejectBlock) reject
                  )

RCT_EXTERN_METHOD(
                  seedFromMnemonic: (nonnull NSString) mnemonicPhrase
                  resolve: (RCTPromiseResolveBlock) resolve
                  rejecter: (RCTPromiseRejectBlock) reject
                  )

RCT_EXTERN_METHOD(
                  seedFromEntropy: (nonnull NSString) entropy
                  resolve: (RCTPromiseResolveBlock) resolve
                  rejecter: (RCTPromiseRejectBlock) reject
                  )

RCT_EXTERN_METHOD(
                  derive: (nonnull NSString) seed
                  path: (nonnull NSString) path
                  resolve: (RCTPromiseResolveBlock) resolve
                  rejecter: (RCTPromiseRejectBlock) reject
                  )
RCT_EXTERN_METHOD(
                  accountInfo: (nonnull NSString) privatekey
                  resolve: (RCTPromiseResolveBlock) resolve
                  rejecter: (RCTPromiseRejectBlock) reject
                  )

RCT_EXTERN_METHOD(
                sign: (nonnull NSString) privateKey
                message: (nonnull NSString) message
                resolve: (RCTPromiseResolveBlock) resolve
                rejecter: (RCTPromiseRejectBlock) reject
                )

RCT_EXTERN_METHOD(
                hashMessage: (nonnull NSString) message
                resolve: (RCTPromiseResolveBlock) resolve
                rejecter: (RCTPromiseRejectBlock) reject
                )

+ (BOOL)requiresMainQueueSetup
{
  return NO;
}

@end
