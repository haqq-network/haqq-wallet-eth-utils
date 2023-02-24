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
  useColorScheme,
} from 'react-native';

import {Colors,} from 'react-native/Libraries/NewAppScreen';
import {
  generateEntropy,
  generateMnemonicFromEntropy,
  seedFromMnemonic
} from '@haqq/provider-web3-utils';

function App(): JSX.Element {
  const isDarkMode = useColorScheme() === 'dark';
  const [entropy, setEntropy] = useState<null | Buffer>(null)
  const [mnemonic, setMnemonic] = useState('')
  const [seed, setSeed] = useState('')

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
      if(e instanceof Error) {
        // tslint:disable-next-line:no-console
        console.log(e.message);
      }
    }
  }, [])

  const onPressGenerateSeed = useCallback(async () => {
    if (mnemonic) {
      const seedResult = await seedFromMnemonic(mnemonic);
      setSeed(seedResult)
    }
  }, [mnemonic])

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
    </SafeAreaView>
  );
}

export default App;
