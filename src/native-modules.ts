import {NativeModules, Platform} from 'react-native';

const LINKING_ERROR =
  `The package '@haqq/provider-web3-utils' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ios: '- You have run \'pod install\'\n', default: ''}) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo Go\n';

const HaqqWeb3UtilsRN = NativeModules.HaqqWeb3UtilsRN
  ? NativeModules.HaqqWeb3UtilsRN
  : new Proxy(
    {},
    {
      get() {
        throw new Error(LINKING_ERROR);
      },
    }
  );

/**
 * Generate mnemonic with strength
 *
 * @param {number} strength - Strength for mnemonic
 * @returns - Promise resolving to stringified data
 */
export function generateMnemonic(
  strength = 16
): Promise<string> {
  return HaqqWeb3UtilsRN.generateMnemonic(strength);
}


export function seedFromMnemonic(mnemonicPhrase: string): Promise<string> {
  return HaqqWeb3UtilsRN.seedFromMnemonic(mnemonicPhrase);
}

export function derive(seed: string, path: string): Promise<string> {
  return HaqqWeb3UtilsRN.derive(seed, path);
}

/**
 * Get account address and public key by privateKey
 * @param {string} privateKey Private key
 */
export function accountInfo(privateKey: string): Promise<{publicKey: string, address: string}> {
  return HaqqWeb3UtilsRN.accountInfo(privateKey);
}

/**
 * Sign transaction
 *
 * @returns - Promise resolving to stringified data
 * @param {string} privateKey private key
 * @param {string} message message for signing
 * @returns - Promise resolving to stringified data
 */
export function sign(privateKey: string, message: string): Promise<string> {
  return HaqqWeb3UtilsRN.sign(privateKey, message);
}
