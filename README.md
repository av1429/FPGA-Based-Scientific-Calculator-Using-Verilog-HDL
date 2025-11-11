# 🔢 FPGA-Based Scientific Calculator (DE2-115)

## 📘 Overview
This project implements a **Scientific Calculator on the DE2-115 FPGA board** using **Verilog and SystemVerilog**.  
It supports **38 verified hardware functions** and **53 designed functions**, categorized across arithmetic, bitwise, conversion, statistical, and logical operations.  
All computations are performed in **hardware logic**, enabling **real-time execution** with efficient FPGA resource utilization.  

The project demonstrates the potential of **FPGAs for mathematical computation**, replacing microcontrollers or software-based calculators with parallel, low-latency hardware execution.

---

## ⚙️ Features
- **53 total designed functions**, with **38 fully implemented and verified** on FPGA hardware.
- Modular HDL structure with separate Verilog modules for each function group.
- **Switch-based control** (`SW[5:0]`) to select among 53 operations.
- **LCD integration** for displaying computation results in real time.
- **LED-based binary display** for debugging and bitwise function visualization.
- **ModelSim simulation** and **Quartus compilation reports** validated functional correctness and timing closure.

### 🧮 Function Categories
| Category | Example Functions |
|-----------|-------------------|
| Arithmetic | Add, Subtract, Multiply, Divide |
| Bitwise & Number Handling | AND, OR, XOR, Shifts, GCD, LCM |
| Conversion | Binary ↔ Decimal, Hex ↔ BCD, Octal |
| Statistical | Mean, Max, Min |
| Boolean | Even/Odd, Equal, Greater/Lesser |
| Miscellaneous | Factorial, Permutation (nPr), Combination (nCr) |

---

## 🧠 System Architecture
Each functional group is implemented as an independent **Verilog module** and interfaced through a **top-level control module**.  
The calculator accepts two operands (`a`, `b`), a **6-bit function selector**, and outputs a **32-bit result** to the LCD.

### 🔩 Core Modules
| Module | Function |
|---------|-----------|
| `arith_unit.v` | Basic arithmetic logic |
| `bitwise_unit.v` | Bitwise operations and number handling |
| `conv_unit.v` | Number system conversions |
| `stat_unit.v` | Statistical computations |
| `bool_unit.v` | Boolean and comparison logic |
| `misc_unit.v` | Factorial, nPr, nCr |
| `lcd_display.v` | 16x2 LCD driver module |
| `controller.v` | Function selector and top-level integration |

---

## 🧮 Functional Flow

- Operands (A, B) → Function Selector (Switches SW[5:0]) → HDL Module → Result → LCD Display / LEDs

---

## 🔬 Simulation & Testing
- Verified all **53 modules** using **ModelSim**.
- Each function tested with fixed operand pairs (A = 12, B = 4).
- Results validated using waveform and transcript outputs.
- Edge cases tested (division by zero, factorial overflow, etc.).
- LCD and LED outputs confirmed on physical board for 38 verified functions.

---

## 📊 FPGA Resource Utilization

| Configuration | Logic Elements | Registers | Utilization | Compilation Time |
|----------------|----------------|------------|--------------|------------------|
| 53 Functions (No LCD) | 7823 | 4188 | 7% | 1m 44s |
| 38 Functions (With LCD) | 4769 | 95 | 4% | 38s |

✅ The LCD-integrated 38-function version achieved **4% FPGA logic utilization**, showing **high efficiency** and fast compilation.

---

## ⏱️ Timing Summary
| Metric | Result (ns) | Comment |
|---------|--------------|----------|
| Hold Slack | +0.402 | Meets timing safely |
| Setup Slack | -4.630 | Minor violation due to LCD data path delay |

Minor setup timing violations were identified in the LCD control path, which can be optimized by restructuring logic depth or adjusting clock constraints.


---

## 🧰 Tools & Environment
- **Hardware:** Terasic DE2-115 FPGA Board  
- **Display Interface:** 16x2 LCD Module  
- **Software:** Intel Quartus Prime, ModelSim  
- **HDL:** Verilog / SystemVerilog  
- **Operating Frequency:** 50 MHz  

---

## 🚀 Future Work
- Integrate **floating-point support** using IEEE 754 IP cores.  
- Extend LCD interface to **VGA** for advanced display output.  
- Add **PS/2 keyboard input** for real-time user operands.  
- Support for **expression parsing** (e.g., A + B - C × D).  
- Implement **trigonometric and logarithmic** functions using fixed-point approximation.  
- Upgrade operand width (32-bit to 64-bit) for larger computations.  

---

## 🧑‍💻 Author
**Aravinthvasan S**  
B.Tech Electronics & Communication Engineering (Cyber Physical Systems)  
SASTRA Deemed University  

🔗 [GitHub Profile](https://github.com/av1429)

---

## 🪪 License
This project is licensed under the **MIT License** — you are free to use, modify, and distribute with attribution.





## 🧮 Functional Flow
