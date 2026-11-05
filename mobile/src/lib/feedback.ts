import { createAudioPlayer, setAudioModeAsync, type AudioPlayer } from 'expo-audio';
import * as Haptics from 'expo-haptics';
import { Platform } from 'react-native';

import { useSettings } from '@/store/settings';

const TAP_SOUND = require('../../assets/sounds/tap.wav');

let player: AudioPlayer | null = null;

function tapPlayer() {
  if (!player) {
    // Mix with whatever else is playing (music, podcasts) and honour the silent switch.
    setAudioModeAsync({ interruptionMode: 'mixWithOthers', playsInSilentMode: false }).catch(() => {});
    player = createAudioPlayer(TAP_SOUND);
    player.volume = 0.6;
  }
  return player;
}

function playTap() {
  if (!useSettings.getState().soundEnabled) return;
  try {
    const p = tapPlayer();
    // Rewind so rapid taps each make a sound.
    p.seekTo(0).catch(() => {});
    p.play();
  } catch {
    // Sound is decoration — never let it break a press.
  }
}

type HapticKind = 'light' | 'selection';

/** Press feedback for every tappable control: a short pop plus a haptic tick. */
export function tapFeedback(haptic: HapticKind = 'light') {
  playTap();
  if (Platform.OS === 'web') return;
  const run = haptic === 'selection' ? Haptics.selectionAsync() : Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Light);
  run.catch(() => {});
}
