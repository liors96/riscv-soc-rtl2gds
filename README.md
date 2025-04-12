# RISC-V SoC Design Flow — RTL to GDSII

This project implements a **System-on-Chip (SoC)** based on a **RISC-V processor core (RI5CY)**. The complete VLSI flow was performed, starting from a high-level C program to a fully placed-and-routed GDSII layout using Cadence tools.

---

## 📦 Project Overview

This final project is divided into three main stages:

1. **Stage 1: RISC-V Toolchain & RTL Simulation**
   - A C program (bubble sort) is compiled using the RISC-V GCC toolchain.
   - The compiled binary is loaded into simulated memory.
   - RTL simulation verifies correct program execution on the SoC.

2. **Stage 2: SoC Synthesis**
   - Memory macros are compiled and wrapped.
   - Instruction and data SRAM wrappers are integrated into the RTL.
   - RTL is synthesized using **Cadence Genus**, and timing reports are generated.

3. **Stage 3: Place & Route**
   - Floorplan and I/O ring are defined in **Cadence Innovus**.
   - Placement, clock tree synthesis, and routing are completed.
   - Post-layout DRC, connectivity, and timing are verified.

---

## 🧠 Key Features

- ✅ RISC-V RI5CY core (4-stage, from PULPino platform)
- ✅ Harvard architecture with separate instruction & data memory
- ✅ Simulation of a compiled C program (Bubble Sort)
- ✅ SRAM wrappers for realistic memory integration
- ✅ RTL simulation + synthesis + full PnR flow
- ✅ Timing closure and power-aware layout