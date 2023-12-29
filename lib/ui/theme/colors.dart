import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'package:flutter/material.dart';

const Purple80 = Color(0xFFD0BCFF);
const PurpleGrey80 = Color(0xFFCCC2DC);
const Pink80 = Color(0xFFEFB8C8);

const Purple40 = Color(0xFF6650a4);
const PurpleGrey40 = Color(0xFF625b71);
const Pink40 = Color(0xFF7D5260);

const PurpleStart = Color(0xFFD24BE9);
const PurpleEnd = Color(0xFFDF8FEC);

final BlueStart = Color(0xFF2196F3);
const BlueEnd = Color(0xFF79C3FD);

final OrangeStart = Color(0xFFFF8400);
final OrangeEnd = Color(0xFFFDA35F);

final GreenStart = Color(0xFF11B114);
final GreenEnd = Color(0xFF52DB59);

final WhiteStart = Color(0xFFFFFFFF);
final WhiteEnd = Color(0xFF868686);

final Primary = Color(0xFF92A3FD);
final Secondary = Color(0xFF9DCEFF);
final TextColor = Color(0xFF1D1617);
final AccentColor = Color(0xFFC58BF2);
final GrayColor = Color(0xFF7B6F72);
final WhiteColor = Color(0xFFFFFFFF);
final BgColor = Color(0xFFF7F8F8);

// Make a light ColorScheme from the seeds.
final ColorScheme schemeLight = SeedColorScheme.fromSeeds(
  brightness: Brightness.light,
  // Primary key color is required, like seed color ColorScheme.fromSeed.
  primaryKey: Primary,
  // You can add optional own seeds for secondary and tertiary key colors.
  secondaryKey: Secondary,
  tertiaryKey: Primary,
  // Tone chroma config and tone mapping is optional, if you do not add it
  // you get the config matching Flutter's Material 3 ColorScheme.fromSeed.
  tones: FlexTones.vivid(Brightness.light),
);

// Make a dark ColorScheme from the seeds.
final ColorScheme schemeDark = SeedColorScheme.fromSeeds(
  brightness: Brightness.dark,
  primaryKey: Primary,
  secondaryKey: Secondary,
  tertiaryKey: Primary,
  tones: FlexTones.vivid(Brightness.dark),
);
