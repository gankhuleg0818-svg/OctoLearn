import { LinearGradient } from 'expo-linear-gradient';
import { useEffect, useRef } from 'react';
import { StyleSheet, View } from 'react-native';
import Animated, { useAnimatedStyle, useSharedValue, withSequence, withSpring, withTiming } from 'react-native-reanimated';
import { useSafeAreaInsets } from 'react-native-safe-area-context';

import type { ProgressSummary } from '@/api/types';
import { ProgressBar } from '@/components/ui/progress-bar';
import { Text } from '@/components/ui/text';
import { Fonts, Radius, Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';

const GRADIENT = {
  light: ['#FF6A00', '#FF8A1F', '#FF6A00'] as const,
  dark: ['#db5b00', '#FF8A1F', '#db5b00'] as const,
};

/** Pops when the value changes (e.g. XP gained) for a little reward feel. */
function StatPill({ icon, value, label }: { icon: string; value: number; label: string }) {
  const scale = useSharedValue(1);
  const prev = useRef(value);
  useEffect(() => {
    if (value !== prev.current) {
      scale.set(withSequence(
        withTiming(1.3, { duration: 150 }),
        withTiming(1, { duration: 150 })
      ));
      prev.current = value;
    }
  }, [value, scale]);
  const style = useAnimatedStyle(() => ({ transform: [{ scale: scale.get() }] }));

  return (
    <Animated.View style={[styles.pill, style]} accessible accessibilityLabel={`${label}: ${value}`}>
      <Text style={styles.pillIcon}>{icon}</Text>
      <Text style={styles.pillValue}>{value} {label}</Text>
    </Animated.View>
  );
}

export function TopBar({ summary, courseTitle }: { summary: ProgressSummary; courseTitle: string }) {
  const t = useTheme();
  // The gradient runs under the status bar, so it applies the top inset itself.
  const insets = useSafeAreaInsets();
  return (
    <LinearGradient
      colors={t.scheme === 'dark' ? GRADIENT.dark : GRADIENT.light}
      start={{ x: 0, y: 0 }}
      end={{ x: 1, y: 1 }}
      style={[styles.bar, { paddingTop: insets.top + Spacing.sm }]}>
      <View style={styles.row}>
        <StatPill icon="🔥" value={summary.streak} label="Streak" />
        <View style={styles.titleWrap}>
          {/* <Text style={styles.mapIcon}>🗺️</Text> */}
          <Text variant="bodyBold" numberOfLines={1} style={styles.title}>
            {courseTitle}
          </Text>
        </View>
        <StatPill icon="⚡" value={summary.totalXp} label="XP" />
      </View>
      <View style={styles.row}>
        <ProgressBar
          percent={summary.percent}
          color={t.gold}
          trackColor="rgba(255,255,255,0.4)"
          accessibilityLabel="Курсын ахиц"
          style={{ flex: 1 }}
        />
        <Text variant="caption" style={styles.count}>
          {summary.completedLessons}/{summary.totalLessons} хичээл · {summary.percent}%
        </Text>
      </View>
    </LinearGradient>
  );
}

const styles = StyleSheet.create({
  bar: {
    paddingHorizontal: Spacing.lg,
    paddingTop: Spacing.sm,
    paddingBottom: Spacing.md,
    gap: Spacing.sm,
    borderBottomLeftRadius: Radius.xl,
    borderBottomRightRadius: Radius.xl,
  },
  row: { flexDirection: 'row', alignItems: 'center', justifyContent: 'space-between', gap: Spacing.sm },
  titleWrap: { flexDirection: 'row', alignItems: 'center', gap: 6 },
  mapIcon: { fontSize: 18 },
  title: { color: '#fff', flexShrink: 1 },
  pill: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 4,
    minHeight: 32,
    paddingHorizontal: 10,
    borderRadius: Radius.full,
    backgroundColor: 'rgba(255,255,255,0.2)',
  },
  pillIcon: { fontSize: 16 },
  pillValue: { fontFamily: Fonts.black, fontSize: 16, color: '#fff' },
  count: { minWidth: 112, textAlign: 'right', color: 'rgba(255,255,255,0.92)' },
});
