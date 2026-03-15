# KOF Training Mode Features

This project extends the FBNeo training mode with advanced features specifically designed for King of Fighters. It provides comprehensive tools for practicing setups, reversals, and analyzing game mechanics.

## Core Features

### 🛡️ Guard Settings
Customize how the dummy defends against attacks:
- **Guard Modes**:
  - **Off**: Dummmy acts normally.
  - **On**: Dummy blocks all attacks.
  - **Random**: Dummy randomly blocks attacks.
  - **All Guard**: Dummy holds block.
  - **1 Hit Guard**: Dummy blocks only the first hit of a combo.
- **Guard Stance**: Force the dummy to block **Standing** or **Crouching**.

### 🔄 Reversal System
Program the dummy to react instantly to specific situations. Great for testing frame traps and punishes.
- **Wakeup Reversal**: Perform a move immediately after waking up from a knockdown.
- **Guard Reversal**: Perform a move immediately after blocking an attack (Guard Cancel).
- **Hit Reversal**: Perform a move immediately after being hit.
- **Configuration**:
  - **Mode**: Set to **On**, **Off**, or **Random** (to simulate human error/mixups).
  - **Move List**: Select specific moves (Command Normals, Specials, Supers) or custom Recordings to use as reversals.

### 📼 Recording & Playback
record and replay dummy actions to practice defense or setups.
- **5 Recording Slots**: Store up to 5 unique actions.
- **Setups**: Save and Load complete training states (Rec 1-5 + Game Settings) for specific matchups.
- **Replay**: Use recordings as Reversals or standard playback.

### 🎮 Dummy & CPU Options
- **Tech Recovery**: Toggle automatic recovery rolls with adjustable **Delay** (frames) and **Times** (repetition).
- **CPU Control**: Enable AI control with difficulty settings ranging from **Beginner** to **Expert**.
- **Guard Cancels**: Configure the CPU/Dummy to use **GCCD** (Guard Cancel Blowback) or **GCAB** (Guard Cancel Roll).
- **Dizzy**: Enable/Disable dizzy (stun) mechanics.

### 📊 Debug & Info Display
Visualize hidden game data in real-time:
- **Advantage**: Frame advantage on hit/block.
- **Block**: Blockstun frames.
- **Distance**: Pixel distance between characters.
- **Position**: X/Y coordinates.
- **Action**: Current action/animation ID.
- **Stun**: Current dizzy ranking/values.
- **Inputs**: Real-time input display.

### ⚙️ Player Settings
- **Character Select**: Change P1 and P2 characters directly from the training menu without resetting the game.
- **P2 State**:
  - **Counter Hit**: Force P2 into a Counter Hit state.
  - **Guard Break**: specific Guard Break behaviors (Normal, Never, Always).
- **P1 Options**:
  - **Crouch Guard**: Enable auto-crouch guard for P1 testing.

### 🛠️ Utilities
- **Throw OS**: Toggle "Throw Option Select" on Jump.
- **Predefined Macros**: Quick access to common actions like **Hyper Hop**, **Super Jump**, **CD counters**, and **AB rolls**.
