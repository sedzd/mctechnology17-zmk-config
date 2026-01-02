# Corne Keyboard ZMK Config

[![MC Technology](https://github.com/mctechnology17/mctechnology17/blob/main/src/mctechnology_extendido.GIF)](https://www.youtube.com/channel/UC_mYh5PYPHBJ5YYUj8AIkcw)

<div align="center">

  [<img align="center" alt="MC Technology | YouTube" width="22px" src="https://github.com/mctechnology17/mctechnology17/blob/main/src/youtube.png" />][youtube]
  [<img align="center" alt="MC Technology17 | Facebook" width="22px" src="https://github.com/mctechnology17/mctechnology17/blob/main/src/facebook.png" />][facebook]
  [<img align="center" alt="MC Technology17 | Reddit" width="22px" src="https://github.com/mctechnology17/mctechnology17/blob/main/src/reddit.png" />][reddit]

</div>
<br>

ZMK firmware configuration for the **Corne** split keyboard with **nice!nano v2** microcontroller.

## Table of Contents

- [Quick Start](#quick-start)
- [Keymap](#keymap)
- [Displays](#displays)
- [Dongle Setup](#dongle-setup)
- [ZMK Studio](#zmk-studio)
- [Maintenance & Troubleshooting](#maintenance--troubleshooting)
- [Local Development](#local-development)
- [Module Integration](#module-integration)
- [Resources](#resources)

---

## Features

| Feature | Description |
|---------|-------------|
| **Wireless** | Bluetooth and USB-C connectivity |
| **Battery** | Up to 1 week with 100mAh battery |
| **Displays** | Supports nice!view (e-paper) and OLED |
| **ZMK Studio** | Real-time keymap editing |
| **Dongle** | Optional USB dongle mode |
| **RGB** | Optional RGB underglow support |
| **Multi-device** | Connect up to 5 devices |

---

## Quick Start

### Using ZMK Studio (Recommended)
1. Fork this repository
2. Go to **Actions** → download the firmware artifacts
3. Flash `nice_corne_left_view.uf2` to left half
4. Flash `nice_corne_right_view.uf2` to right half
5. Connect to [ZMK Studio](https://zmk.studio/) to edit your keymap live!

### Traditional Setup
1. Fork this repository
2. Modify your keymap using [keymap-editor](https://nickcoutsos.github.io/keymap-editor/)
3. Commit changes → GitHub Actions builds firmware
4. Download artifacts from Actions tab
5. Flash `.uf2` files to each keyboard half

### Flashing Firmware
1. Connect the keyboard half via USB-C
2. Double-tap the reset button (enters bootloader mode)
3. Keyboard appears as a USB drive
4. Drag and drop the `.uf2` file
5. Repeat for the other half

---

## Keymap

[![keymap-drawer-corne](keymap-drawer/corne.svg)](https://www.youtube.com/c/mctechnology17)

> **Note**: This SVG is auto-generated when you modify `config/corne.keymap` via the keymap editor.

---

## Displays

### nice!view (E-Paper) - Default
- Ultra-low power consumption
- 30Hz refresh rate
- SSD1306 OLED replacement pinout

### OLED Displays
Supported sizes: 128x32, 128x64, 128x128

To switch from nice!view to OLED, modify the shield overlays in `boards/shields/corne/`.

---

## Animations & Customization

You can customize the animations and widgets on your displays using configuration variables in `config/corne.conf`.

### 🎥 Peripheral Animations
Enable one of these vertical animations for the peripheral (usually right) half:

| Variable | Animation |
|----------|-----------|
| `CONFIG_NICE_OLED_WIDGET_ANIMATION_PERIPHERAL_CAT` | Running Cat (Default) |
| `CONFIG_NICE_OLED_WIDGET_ANIMATION_PERIPHERAL_GEM` | Spinning Gem |
| `CONFIG_NICE_OLED_WIDGET_ANIMATION_PERIPHERAL_HEAD` | Rotating Head |
| `CONFIG_NICE_OLED_WIDGET_ANIMATION_PERIPHERAL_POKEMON` | Random Pokemon |
| `CONFIG_NICE_OLED_WIDGET_ANIMATION_PERIPHERAL_SPACEMAN` | Floating Spaceman |
| `CONFIG_NICE_OLED_WIDGET_ANIMATION_PERIPHERAL_WPM` | WPM Meter/Speedometer |

### 🐈 Central Widgets (Master Side)
Customize the master (usually left) display:

| Variable | Description |
|----------|-------------|
| `CONFIG_NICE_OLED_WIDGET_WPM_BONGO_CAT` | Show Bongo Cat |
| `CONFIG_NICE_OLED_WIDGET_WPM_LUNA` | Show Luna the Dog |
| `CONFIG_NICE_OLED_WIDGET_WPM_SPEEDOMETER` | Show WPM Gauge (Meter) |
| `CONFIG_NICE_OLED_WIDGET_WPM_GRAPH` | Show WPM History Graph |

### ⌨️ Modifiers Widget
Show real-time status of your modifier keys (Ctrl, Shift, Alt, Gui):

| Variable | Description |
|----------|-------------|
| `CONFIG_NICE_OLED_WIDGET_MODIFIERS_INDICATORS` | Enable the modifiers widget |
| `CONFIG_NICE_OLED_WIDGET_MODIFIERS_INDICATORS_FIXED` | Use fixed icons for modifiers |
| `CONFIG_NICE_OLED_WIDGET_MODIFIERS_INDICATORS_FIXED_SYMBOL` | Use symbols (⌃, ⇧, ⌥, ⌘) |
| `CONFIG_NICE_OLED_WIDGET_MODIFIERS_INDICATORS_FIXED_LETTER` | Use letters (C, S, A, G) |

> [!TIP]
> To change an animation, add the desired variable to `config/corne.conf` set to `y` and ensure others are set to `n`. For example:
> ```c
> CONFIG_NICE_OLED_WIDGET_ANIMATION_PERIPHERAL_GEM=y
> CONFIG_NICE_OLED_WIDGET_ANIMATION_PERIPHERAL_CAT=n
> ```

---

## Dongle Setup

Use a separate nice!nano v2 as a USB dongle receiver:

1. Flash `nice_corne_dongle_pro_micro.uf2` to the dongle
2. Flash `nice_corne_left_peripheral_view.uf2` to left half
3. Flash `nice_corne_right_view.uf2` to right half

**Pro tip**: Add a bootloader combo to enter bootloader mode without physical access:

```c
// In your keymap's combos section
combo_bootloader {
    timeout-ms = <50>;
    key-positions = <0 1 2>;  // First 3 keys on left
    bindings = <&bootloader>;
};
```

---

## ZMK Studio

This config includes ZMK Studio support out of the box:

1. Connect the master half (or dongle) via USB
2. Open [zmk.studio](https://zmk.studio/)
3. Edit your keymap in real-time!

> **Note**: `CONFIG_ZMK_STUDIO_LOCKING=n` is set by default, so no unlock macro needed.

---

## Maintenance & Troubleshooting

### 🔧 Common Issues

#### Halves Won't Connect
1. Press reset button on both halves 10 times rapidly
2. If still failing, flash `nice_settings_reset.uf2` to both halves
3. Re-flash the actual firmware

#### Keyboard Not Responding
1. Check battery level
2. Try connecting via USB
3. Double-tap reset to verify bootloader works

#### Bluetooth Issues
- Clear existing pairings on your computer
- Flash settings reset to both halves
- Re-pair fresh

### 🔋 Battery Tips
- Disable RGB for maximum battery life
- nice!view uses 1000x less power than OLED
- Enable `CONFIG_ZMK_SLEEP=y` for auto-sleep

### 📁 Key Files

| File | Purpose |
|------|---------|
| `config/corne.keymap` | Your keymap layout |
| `config/corne.conf` | Keyboard settings (sleep, BLE, etc.) |
| `build.yaml` | GitHub Actions build configuration |
| `boards/shields/corne/` | Shield definitions |

### 🔄 Updating ZMK
1. Update `config/west.yml` with newer ZMK revision
2. Push to trigger rebuild
3. Flash new firmware

### 💾 Backup Your Config
- Commit changes regularly to git
- Your keymap is stored in `config/corne.keymap`
- Settings in `config/corne.conf`

### 🛠️ Useful Keymap Additions

Add these to your keymap for easier maintenance:

```c
// Reset key - restarts firmware
&sys_reset

// Bootloader key - enters flash mode
&bootloader

// Bluetooth profile switching
&bt BT_SEL 0  // Switch to device 0
&bt BT_CLR    // Clear current profile
```

---

## Local Development

### Prerequisites
- [Docker](https://www.docker.com/products/docker-desktop/)

### Build Commands
```bash
# Initialize ZMK codebase (urob's fork)
make codebase_urob

# Build all Corne firmware
make corne_urob

# Open shell in build environment
make shell

# Clean build artifacts
make clean
```

### Repository Structure
```
zmk-config/
├── boards/
│   ├── nice_nano_v2.overlay
│   └── shields/corne/          # Corne shield files
├── config/
│   ├── corne.conf              # Your settings
│   ├── corne.keymap            # Your keymap
│   └── west.yml                # ZMK module config
├── firmware/                   # Pre-built .uf2 files
├── keymap-drawer/              # Visual keymap SVG
├── build.yaml                  # CI build config
└── Makefile                    # Local build commands
```

---

## Module Integration

### Modules Used
- [nice_view_gem](https://github.com/M165437/nice-view-gem) - nice!view customization
- [nice_oled](https://github.com/mctechnology17/zmk-nice-oled) - OLED widgets
- [zmk-dongle-display](https://github.com/englmaxi/zmk-dongle-display) - Dongle display support

### Using This Repo as a Module
Add to your `config/west.yml`:

```yaml
manifest:
  remotes:
    - name: zmkfirmware
      url-base: https://github.com/zmkfirmware
    - name: mctechnology17
      url-base: https://github.com/mctechnology17
  projects:
    - name: zmk
      remote: zmkfirmware
      revision: main
      import: app/west.yml
    - name: zmk-config
      remote: mctechnology17
      revision: main
  self:
    path: config
```

---

## Resources

### Official Documentation
- [ZMK Documentation](https://zmk.dev/docs/user-setup)
- [ZMK Keycodes](https://zmk.dev/docs/codes)
- [ZMK Discord](https://zmk.dev/community/discord/invite)

### Tools
- [ZMK Studio](https://zmk.studio/) - Real-time keymap editor
- [Keymap Editor](https://nickcoutsos.github.io/keymap-editor/) - Visual keymap editor
- [Keymap Drawer](https://keymap-drawer.streamlit.app/) - Generate keymap SVGs

### Inspirations
- [urob/zmk-config](https://github.com/urob/zmk-config)
- [englmaxi/zmk-config](https://github.com/englmaxi/zmk-config)
- [caksoylar/zmk-config](https://github.com/caksoylar/zmk-config)

---

## Support

If you find this useful:
- ⭐ Star this repository
- 📺 Subscribe on [YouTube][youtube]
- ☕ [Sponsor me](https://github.com/sponsors/mctechnology17) or [PayPal](https://www.paypal.me/mctechnology17)

---

> **Disclaimer**: Use at your own risk. I am not responsible for any damage.

[github]: https://github.com/mctechnology17
[youtube]: https://www.youtube.com/c/mctechnology17
[facebook]: https://m.facebook.com/mctechnology17/
[reddit]: https://www.reddit.com/user/mctechnology17
