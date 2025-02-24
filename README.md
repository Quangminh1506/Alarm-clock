# Digital Clock with Alarm in Verilog

This project implements a digital clock with an alarm feature in Verilog, designed for the Arty Z7-20 FPGA board (Rev. B). It displays hours and minutes on two sets of 7-segment displays—one for the current time and one for the alarm time—while supporting user interaction via buttons and switches.

## Overview

The digital clock counts time in a 24-hour format (hours: 0-23, minutes: 0-59, seconds: 0-59) and includes an adjustable alarm. It uses the FPGA’s clock signal (125 MHz) to increment time every second and drives 7-segment displays to show the current time and alarm settings. LEDs indicate alarm status, and buttons allow setting the alarm.

## Features

- **24-Hour Clock**: Displays hours (00-23) and minutes (00-59) on a 4-digit 7-segment display.
- **Alarm Functionality**: Set an alarm time using buttons, with LED indicators when the current time matches the alarm.
- **User Controls**:
  - Buttons to increment alarm hours and minutes.
  - Switches to enable alarm or sync clock to alarm time.
  - Reset for both clock and alarm.
- **Modular Design**: Separates timekeeping, display logic, and 7-segment decoding into distinct modules.

## Files

- `clock.v`: Core module handling timekeeping, alarm logic, and I/O integration.
- `arty_z7_20.xdc`: Constraints file mapping design signals to Arty Z7-20 pins (e.g., clock, buttons, switches, LEDs, 7-segment displays).
- `DisplaySegment.v`: Module to multiplex hours and minutes onto a 4-digit 7-segment display.
- `segment.v`: Decoder converting 4-bit numbers (0-9) to 7-segment patterns.

## Requirements

- **Hardware**: Arty Z7-20 FPGA board (Rev. B).
- **Tools**: Xilinx Vivado (or similar FPGA toolchain) for synthesis and implementation.
- **Simulation**: Verilog simulator (e.g., ModelSim or Vivado Simulator) for testing (optional testbench not included).


## Usage

1. **FPGA Deployment**:
   - Clone or download this repository.
   - Open the project in Vivado.
   - Add `clock.v`, `DisplaySegment.v`, `segment.v`, and `constraint.txt` to your project.
   - Synthesize, implement, and generate the bitstream.
   - Program the Arty Z7-20 board.

2. **Operation**:
   - **Clock**: Runs automatically, incrementing every second (LED0 blinks).
   - **Alarm Setting**: Press Button 2 (`btn[1]`) to increment alarm hours, Button 1 (`btn[0]`) to increment alarm minutes by 10.
   - **Alarm Enable**: Set Switch 1 (`sw[1]`) to 1 to activate the alarm (LED4_B and LED5_B light up when time matches).
   - **Sync Clock**: Set Switch 0 (`sw[0]`) to 1 to set the clock to the alarm time.
   - **Reset**: Button 0 resets the clock; Button 3 resets the alarm.
