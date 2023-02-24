import Foundation

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
        } catch {
          reject("0", "generateMnemonicFromEntropy \(error)", nil)
        }
    }

    @objc
    public func generateMnemonic(_ strength: Optional<NSNumber>, resolve: RCTPromiseResolveBlock, rejecter reject: RCTPromiseRejectBlock) -> Void {
      do {
        let strength =  Int(truncating: strength ?? 16)

        let mnemonic = Mnemonic(bytes: Mnemonic.generateEntropy(strength: strength))

        if !mnemonic.isValid {
          throw Web3UtilsError.mnemonic_invalid
        }

        resolve(mnemonic.mnemonic.joined(separator: " "))
      } catch {
        reject("0", "generateMnemonic \(error)", nil)
      }
    }

    @objc
    public func seedFromMnemonic(_ mnemonicPhrase: Optional<String>, resolve: RCTPromiseResolveBlock, rejecter reject: RCTPromiseRejectBlock) -> Void {
        do {
            guard let mnemonicPhrase = mnemonicPhrase else {
              throw Web3UtilsError.mnemonic_not_found;
            }

            let mnemonic = Mnemonic(phrase: mnemonicPhrase, pass: "")

            if !mnemonic.isValid {
              throw Web3UtilsError.mnemonic_invalid
            }
            resolve(Data(mnemonic.seed).toHexString())
        } catch {
            reject("0", "seedFromMnemonic \(error)", nil)
        }
    }

    @objc
    public func derive(_ seed: Optional<String>, path: Optional<String>, resolve: RCTPromiseResolveBlock, rejecter reject: RCTPromiseRejectBlock) -> Void {
        do {
            guard let seed = seed else {
              throw Web3UtilsError.hdkey_seed
            }

            guard let path = path else {
                throw Web3UtilsError.hdkey_path
            }

            guard let hdkey = try? HDKey(seed: Array(hex: seed)) else {
                throw Web3UtilsError.hdkey_init
            }

            guard let child = hdkey.derive(path: path) else {
              throw Web3UtilsError.hdkey_derive
            }

            resolve("0x\(Data(child.privateKey).toHexString())")
        } catch {
            reject("0", "derive \(error)", nil)
        }
    }

    @objc
    public func accountInfo(_ privateKey: Optional<String>, resolve: RCTPromiseResolveBlock, rejecter reject: RCTPromiseRejectBlock) -> Void {
        do {
            guard let privateKey = privateKey else {
              throw Web3UtilsError.private_key_not_found;
            }

            let wallet = Wallet(privateKey: privateKey)

            let resp = AccountInfoResponse(
              address: "0x\(Data(wallet.address).toHexString())",
              publicKey: "0x\(Data(wallet.publicKey).toHexString())"
            )

            let json = try! resp.toJSON()
            resolve(json)
        } catch {
          reject("0", "sign \(error)", nil)
        }
    }

    @objc
    public func sign(_ privateKey: Optional<String>, message: Optional<String>, resolve: RCTPromiseResolveBlock, rejecter reject: RCTPromiseRejectBlock)-> Void {
      do {
        guard let privateKey = privateKey else {
          throw Web3UtilsError.private_key_not_found;
        }

        guard let message = message else {
          throw Web3UtilsError.message_not_found;
        }

        let wallet = Wallet(privateKey: privateKey)

        let sig = try wallet.sign(Array(hex: message))

        resolve(Data(sig).toHexString())
      } catch {
        reject("0", "sign \(error)", nil)
      }
    }
}
