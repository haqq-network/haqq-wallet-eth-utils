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
 * Generate entropy with strength
 *
 * @param {number} strength - Strength for entropy
 * @returns - Promise resolving to stringifies data
 */
export function generateEntropy(
  strength = 16
): Promise<Buffer> {
  return HaqqWeb3UtilsRN.generateEntropy(strength).then((resp: string) => new Buffer(resp, 'base64'));
}

/**
 * Generate mnemonic from entropy
 *
 * @param {Buffer} entropy - Entropy for mnemonic
 * @returns - Promise resolving to stringifies data
 */
export function generateMnemonicFromEntropy(entropy: Buffer): Promise<string> {
  return HaqqWeb3UtilsRN.generateMnemonicFromEntropy(entropy.toString('base64'))
}

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

/**
 * Generate seed phrase from mnemonic string
 *
 * @param {string} mnemonicPhrase - Mnemonic phrase
 * @returns - Promise resolving to stringified data
 */
export function seedFromMnemonic(mnemonicPhrase: string): Promise<string> {
  return HaqqWeb3UtilsRN.seedFromMnemonic(mnemonicPhrase);
}

/**
 * Derive hd path for seed phrase
 *
 * @param {string} seed - Seed phrase
 * @param {string} path - HD path
 * @returns - Promise resolving to stringified data
 */
export function derive(seed: string, path: string): Promise<string> {
  return HaqqWeb3UtilsRN.derive(seed, path);
}

/**
 * Get account address and public key by privateKey
 * @param {string} privateKey Private key
 */
export function accountInfo(privateKey: string): Promise<{publicKey: string, address: string}> {
  return HaqqWeb3UtilsRN.accountInfo(privateKey).then((r: string) => JSON.parse(r));
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


/**
 * Hash message
 *
 * @returns - Promise resolving to stringified data
 * @param {string} message message for signing
 * @returns - Promise resolving to stringified data
 */
export function hashMessage(message: string): Promise<string> {
  return HaqqWeb3UtilsRN.hashMessage(message);
}
