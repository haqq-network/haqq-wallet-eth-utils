[@haqq/provider-web3-utils - v0.0.7](README.md) / Exports

# @haqq/provider-web3-utils - v0.0.7

## Table of contents

### Functions

- [accountInfo](modules.md#accountinfo)
- [derive](modules.md#derive)
- [generateEntropy](modules.md#generateentropy)
- [generateMnemonic](modules.md#generatemnemonic)
- [seedFromMnemonic](modules.md#seedfrommnemonic)
- [sign](modules.md#sign)

## Functions

### accountInfo

▸ **accountInfo**(`privateKey`): `Promise`<{ `address`: `string` ; `publicKey`: `string`  }\>

Get account address and public key by privateKey

#### Parameters

| Name | Type | Description |
| :------ | :------ | :------ |
| `privateKey` | `string` | Private key |

#### Returns

`Promise`<{ `address`: `string` ; `publicKey`: `string`  }\>

#### Defined in

[native-modules.ts:57](https://github.com/haqq-network/haqq-wallet-provider-web3-utils/blob/73986a6/src/native-modules.ts#L57)

___

### derive

▸ **derive**(`seed`, `path`): `Promise`<`string`\>

#### Parameters

| Name | Type |
| :------ | :------ |
| `seed` | `string` |
| `path` | `string` |

#### Returns

`Promise`<`string`\>

#### Defined in

[native-modules.ts:49](https://github.com/haqq-network/haqq-wallet-provider-web3-utils/blob/73986a6/src/native-modules.ts#L49)

___

### generateEntropy

▸ **generateEntropy**(`strength?`): `Promise`<`Buffer`\>

Generate entropy with strength

#### Parameters

| Name | Type | Default value | Description |
| :------ | :------ | :------ | :------ |
| `strength` | `number` | `16` | Strength for entropy |

#### Returns

`Promise`<`Buffer`\>

- Promise resolving to stringifies data

#### Defined in

[native-modules.ts:26](https://github.com/haqq-network/haqq-wallet-provider-web3-utils/blob/73986a6/src/native-modules.ts#L26)

___

### generateMnemonic

▸ **generateMnemonic**(`strength?`): `Promise`<`string`\>

Generate mnemonic with strength

#### Parameters

| Name | Type | Default value | Description |
| :------ | :------ | :------ | :------ |
| `strength` | `number` | `16` | Strength for mnemonic |

#### Returns

`Promise`<`string`\>

- Promise resolving to stringified data

#### Defined in

[native-modules.ts:38](https://github.com/haqq-network/haqq-wallet-provider-web3-utils/blob/73986a6/src/native-modules.ts#L38)

___

### seedFromMnemonic

▸ **seedFromMnemonic**(`mnemonicPhrase`): `Promise`<`string`\>

#### Parameters

| Name | Type |
| :------ | :------ |
| `mnemonicPhrase` | `string` |

#### Returns

`Promise`<`string`\>

#### Defined in

[native-modules.ts:45](https://github.com/haqq-network/haqq-wallet-provider-web3-utils/blob/73986a6/src/native-modules.ts#L45)

___

### sign

▸ **sign**(`privateKey`, `message`): `Promise`<`string`\>

Sign transaction

#### Parameters

| Name | Type | Description |
| :------ | :------ | :------ |
| `privateKey` | `string` | private key |
| `message` | `string` | message for signing |

#### Returns

`Promise`<`string`\>

- Promise resolving to stringified data

- Promise resolving to stringified data

#### Defined in

[native-modules.ts:69](https://github.com/haqq-network/haqq-wallet-provider-web3-utils/blob/73986a6/src/native-modules.ts#L69)
