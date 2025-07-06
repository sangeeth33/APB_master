
## 🧠 APB Master Design – SystemVerilog Implementation

This repository contains a synthesizable **APB master module** conforming to the AMBA 3 APB protocol specification. Designed for low-power peripheral transactions, the module features a configurable FSM with protocol-compliant behavior and is UVM-ready for advanced verification flows.

### ✨ Features
- APB-compliant 3-phase transaction handling (`IDLE → SETUP → ENABLE`)
- Supports both **read and write operations**
- Modular design for reuse in **UVM testbenches**
- Clean separation of address, data, and control signals
- Read result capture via delayed sampling to avoid timing glitches

### 🔗 Interface Signals
| Signal       | Direction | Description                       |
|--------------|-----------|-----------------------------------|
| `PCLK`       | input     | System clock                      |
| `PRESETn`    | input     | Active-low reset                  |
| `PADDR`      | output    | Address bus                       |
| `PWRITE`     | output    | Write control (1 = write, 0 = read) |
| `PWDATA`     | output    | Data to slave                     |
| `PRDATA`     | input     | Data from slave                   |
| `PSEL`       | output    | Peripheral select                 |
| `PENABLE`    | output    | Transfer enable                   |
| `PREADY`     | input     | Slave ready signal                |
| `PSLVERR`    | input     | Slave error response              |

### 🧪 Testbench & Verification
Includes a SystemVerilog testbench and a UVM-based test suite with:
- Functional and negative scenarios
- Delayed `PREADY`, error injection, and corner-case tests
- Scoreboard and monitor for protocol validation

