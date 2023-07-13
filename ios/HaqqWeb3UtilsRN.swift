import Foundation
import CryptoSwift

@objc(HaqqWeb3UtilsRN)
class HaqqWeb3UtilsRN: NSObject {
    @objc
    public func generateEntropy(_ strength: NSNumber, resolve: RCTPromiseResolveBlock, rejecter reject: RCTPromiseRejectBlock) -> Void {

        do {
          let strength =  Int(truncating: strength ?? 16)

          let entropy = Mnemonic.generateEntropy(strength: strength)
          resolve(Data(entropy).base64EncodedString())
        } catch {
          reject("0", "generateEntropy \(error)", nil)
        }
    }

    @objc
    public func generateMnemonicFromEntropy(_ entropy: String, resolve: RCTPromiseResolveBlock, rejecter reject: RCTPromiseRejectBlock) -> Void {
        do {
            guard let entropy = Data(base64Encoded: entropy, options: .ignoreUnknownCharacters) else {
                throw Web3UtilsError.entropy_invalid
            }

            let mnemonic = Mnemonic(bytes: entropy.bytes)

            if !mnemonic.isValid {
                throw Web3UtilsError.mnemonic_invalid
            }

            resolve(mnemonic.mnemonic.joined(separator: " "))
            
            mnemonic.clean()
        } catch {
          reject("0", "generateMnemonicFromEntropy \(error)", nil)
        }
    }

    @objc
    public func generateMnemonic(_ strength: NSNumber, resolve: RCTPromiseResolveBlock, rejecter reject: RCTPromiseRejectBlock) -> Void {
      do {
        let strength =  Int(truncating: strength ?? 16)

        let mnemonic = Mnemonic(bytes: Mnemonic.generateEntropy(strength: strength))

        if !mnemonic.isValid {
          throw Web3UtilsError.mnemonic_invalid
        }

        resolve(mnemonic.mnemonic.joined(separator: " "))
          
          mnemonic.clean()
      } catch {
        reject("0", "generateMnemonic \(error)", nil)
      }
    }

    @objc
    public func seedFromMnemonic(_ mnemonicPhrase: String, resolve: RCTPromiseResolveBlock, rejecter reject: RCTPromiseRejectBlock) -> Void {
        do {
            let mnemonic = Mnemonic(phrase: mnemonicPhrase, pass: "")

            if !mnemonic.isValid {
              throw Web3UtilsError.mnemonic_invalid
            }
            resolve(Data(mnemonic.seed).toHexString())
            
            mnemonic.clean()
        } catch {
            reject("0", "seedFromMnemonic \(error)", nil)
        }
    }

    @objc
    public func seedFromEntropy(_ entropy: String, resolve: RCTPromiseResolveBlock, rejecter reject: RCTPromiseRejectBlock) -> Void {
        do {
            guard let entropy = Data(base64Encoded: entropy, options: .ignoreUnknownCharacters) else {
                throw Web3UtilsError.entropy_invalid
            }

            let mnemonic = Mnemonic(bytes: entropy.bytes)

            if !mnemonic.isValid {
              throw Web3UtilsError.mnemonic_invalid
            }
            resolve(Data(mnemonic.seed).toHexString())
            
            mnemonic.clean()
        } catch {
            reject("0", "seedFromEntropy \(error)", nil)
        }
    }
    
    @objc
    public func derive(_ seed: String, path: String, resolve: RCTPromiseResolveBlock, rejecter reject: RCTPromiseRejectBlock) -> Void {
        do {
            guard let hdkey = try? HDKey(seed: Array(hex: seed)) else {
                throw Web3UtilsError.hdkey_init
            }

            guard let child = hdkey.derive(path: path) else {
              throw Web3UtilsError.hdkey_derive
            }

            resolve("0x\(Data(child.privateKey).toHexString())")
            
            hdkey.clean()
            child.clean()
        } catch {
            reject("0", "derive \(error)", nil)
        }
    }

    @objc
    public func accountInfo(_ privateKey: String, resolve: RCTPromiseResolveBlock, rejecter reject: RCTPromiseRejectBlock) -> Void {
        do {
            let wallet = Wallet(privateKey: privateKey)

            let resp = AccountInfoResponse(
              address: "0x\(Data(wallet.address).toHexString())",
              publicKey: "0x\(Data(wallet.publicKey).toHexString())",
              publicKeyUncompressed: "0x\(Data(wallet.publicKeyUncompressed).toHexString())"
            )

            let json = try! resp.toJSON()
            resolve(json)
            
            wallet.clean()
        } catch {
          reject("0", "sign \(error)", nil)
        }
    }

    @objc
    public func sign(_ privateKey: String, message: String, resolve: RCTPromiseResolveBlock, rejecter reject: RCTPromiseRejectBlock)-> Void {
      do {
        let wallet = Wallet(privateKey: privateKey)

        let sig = try wallet.sign(Array(hex: message))

        resolve(Data(sig).toHexString())
          
          wallet.clean()
      } catch {
        reject("0", "sign \(error)", nil)
      }
    }

    @objc
    public func hashMessage(_ message: String, resolve: RCTPromiseResolveBlock, rejecter reject: RCTPromiseRejectBlock)-> Void {
        do {
            let hash = Digest.sha3(message.bytes, variant: .keccak256)
            resolve(Data(hash).toHexString())
        } catch {
            reject("0", "hashMessage \(error)", nil)
        }
    }
}
