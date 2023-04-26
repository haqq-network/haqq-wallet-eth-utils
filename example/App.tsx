/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 */

import React, {useCallback, useState} from 'react';
import {
  Button,
  SafeAreaView,
  StatusBar,
  Text,
  TextInput,
  useColorScheme,
} from 'react-native';

import {Colors,} from 'react-native/Libraries/NewAppScreen';
import {
  accountInfo,
  derive,
  generateEntropy,
  generateMnemonicFromEntropy,
  hashMessage,
  seedFromMnemonic
} from '@haqq/provider-web3-utils';

function App(): JSX.Element {
  const isDarkMode = useColorScheme() === 'dark';
  const [entropy, setEntropy] = useState<null | Buffer>(null)
  const [mnemonic, setMnemonic] = useState('')
  const [seed, setSeed] = useState('')
  const [message, setMessage] = useState('')
  const [hashedMessage, setHashedMessage] = useState('')
  const [privateKey, setPrivateKey] = useState('')
  const [info, setInfo] = useState<null | object>(null)
  const backgroundStyle = {
    backgroundColor: isDarkMode ? Colors.darker : Colors.lighter,
  };

  const onPressGenerateEntropy = useCallback(async () => {
    const ent = await generateEntropy(32);
    setEntropy(ent)
  }, [])

  const onPressGenerateMnemonicFromEntropy = useCallback(async () => {
    try {
      if (entropy) {
        const mnemonicResult = await generateMnemonicFromEntropy(entropy);
        setMnemonic(mnemonicResult)
      }
    } catch (e) {
      if (e instanceof Error) {
        // tslint:disable-next-line:no-console
        console.log(e.message);
      }
    }
  }, [entropy])

  const onPressGenerateSeed = useCallback(async () => {
    if (mnemonic) {
      const seedResult = await seedFromMnemonic(mnemonic);
      setSeed(seedResult)
    }
  }, [mnemonic])

  const onPressDerive = useCallback(async () => {
    if (seed) {
      const privateKeyResult = await derive(seed, 'm/44\'/60\'/0\'/0/0');
      setPrivateKey(privateKeyResult)
    }
  }, [seed])

  const onPressAccountInfo = useCallback(async () => {
    if (privateKey) {
      const infoResult = await accountInfo(privateKey);
      setInfo(infoResult)
    }
  }, [privateKey])

  const onPressHashMessage = useCallback(async () => {
    const text = await hashMessage(message);
    setHashedMessage(text);
  }, [message])

  return (
    <SafeAreaView style={backgroundStyle}>
      <StatusBar
        barStyle={isDarkMode ? 'light-content' : 'dark-content'}
        backgroundColor={backgroundStyle.backgroundColor}
      />

      <Button title="Generate entropy" onPress={onPressGenerateEntropy} />
      <Text>{entropy ? JSON.stringify(entropy) : null}</Text>
      <Button title="Generate mnemonic for entropy" disabled={!entropy}
              onPress={onPressGenerateMnemonicFromEntropy} />
      <Text>{mnemonic}</Text>
      <Button title="Generate seed from mnemonic" disabled={!mnemonic}
              onPress={onPressGenerateSeed} />
      <Text>{seed}</Text>
      <Button title="Derive" disabled={!seed}
              onPress={onPressDerive} />
      <Text>{privateKey}</Text>
      <Button title="Account info" disabled={!privateKey}
              onPress={onPressAccountInfo} />
      <Text>{info ? JSON.stringify(info) : null}</Text>
      <TextInput onChangeText={(text) => setMessage(text)} value={message} />
      <Button title="Hash message"
              onPress={onPressHashMessage} />

      <Text>{hashedMessage}</Text>
    </SafeAreaView>
  );
}

export default App;
