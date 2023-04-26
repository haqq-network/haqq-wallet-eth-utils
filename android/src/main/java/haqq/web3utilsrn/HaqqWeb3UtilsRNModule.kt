package haqq.we3utilsrn

import android.util.Base64
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod
import com.facebook.react.bridge.Promise
import haqq.web3utilsrn.*
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import java.io.IOException
import org.komputing.khash.keccak.Keccak
import org.komputing.khash.keccak.KeccakParameter

class HaqqWeb3UtilsRNModule(reactContext: ReactApplicationContext) :
  ReactContextBaseJavaModule(reactContext) {

  override fun getName(): String {
    return NAME
  }

  companion object {
    const val NAME = "HaqqWeb3UtilsRN"
  }

  @ReactMethod
  fun generateEntropy(strength: Int, promise: Promise) {
    try {
      val entropy = Mnemonic.generateEntropy(strength = strength)

      promise.resolve(Base64.encodeToString(entropy, Base64.NO_WRAP))

    } catch (e: IOException) {
      promise.reject("0", "generateEntropy")
    }
  }

  @ReactMethod
  fun generateMnemonicFromEntropy(entropy: String, promise: Promise) {
    try {
      val bytes = Base64.decode(entropy, Base64.DEFAULT)
      val mnemonic = Mnemonic(bytes = bytes)

      promise.resolve(mnemonic.mnemonic())
    } catch (e: IOException) {
      promise.reject("0", "generateMnemonicFromEntropy")
    }
  }

  @ReactMethod
  fun generateMnemonic(strength: Int, promise: Promise) {
    try {
      val bytes = Mnemonic.generateEntropy(strength = strength)
      val mnemonic = Mnemonic(bytes = bytes)

      promise.resolve(mnemonic.mnemonic())

    } catch (e: IOException) {
      promise.reject("0", "generateMnemonic")
    }
  }

  @ReactMethod
  fun seedFromMnemonic(mnemonicPhrase: String, promise: Promise) {
    try {
      val mnemonic = Mnemonic(phrase = mnemonicPhrase, pass = "")

      if (!mnemonic.isValid()) {
        throw IllegalArgumentException("mnemonic_invalid")
      }

      promise.resolve(mnemonic.seed())
    } catch (_: IOException) {

    } catch (e: java.lang.IllegalArgumentException) {
      promise.reject("0", e)
    }
  }

  @ReactMethod
  fun derive(seed: String, path: String, promise: Promise) {
    try {
      val hdKey = HDKey(seed = seed)
      val child = hdKey.derive(path)

      promise.resolve("0x${child.privateKey().toHex()}")
    } catch (_: IOException) {

    } catch (e: java.lang.IllegalArgumentException) {
      promise.reject("0", e)
    }
  }

  @ReactMethod
  fun accountInfo(privateKey: String, promise: Promise) {
    try {
      val wallet = Wallet(privateKey = privateKey)

      val result = Json.encodeToString(
        AccountInfoResponse(
          address = "0x${wallet.address().toHex()}",
          publicKey = "0x${wallet.publicKey().toHex()}",
          publicKeyUncompressed = "0x${wallet.publicKeyUncompressed().toHex()}"
        )
      )

      promise.resolve(result)
    } catch (_: IOException) {

    } catch (e: java.lang.IllegalArgumentException) {
      promise.reject("0", e)
    }
  }

  @ReactMethod
  fun sign(privateKey: String, message: String, promise: Promise) {
    try {
      val wallet = Wallet(privateKey = privateKey)

      val msg = if (message.startsWith("0x")) {
        message.substring(2)
      } else {
        message
      }

      val resp = wallet.sign(msg.decodeHex())

      promise.resolve(resp.toHex());
    } catch (_: IOException) {

    } catch (e: java.lang.IllegalArgumentException) {
      promise.reject("0", e)
    }
  }

  @ReactMethod
  fun hashMessage(message: String, promise: Promise) {
    try {
      val hash = Keccak.digest(message.toByteArray(), KeccakParameter.KECCAK_256)

      promise.resolve(hash.toHex());
    } catch (e: java.lang.IllegalArgumentException) {
      promise.reject("0", e)
    }
  }
}
