
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

Top 10 test cases

| 🧪 **Test Name**                  | 🎯 **Purpose**                                                | ✅ **Expected Outcome**                                        |
|----------------------------------|---------------------------------------------------------------|----------------------------------------------------------------|
| `apb_write_test`                | Perform a valid write to address                              | Value is stored correctly in slave memory                      |
| `apb_read_test`                 | Read from a location previously written                       | Master receives correct `PRDATA`                              |
| `apb_unwritten_read_test`       | Read from an address that hasn't been written to              | Slave returns default/zero or undefined data                  |
| `apb_b2b_write_test`            | Multiple consecutive writes                                   | All addresses updated correctly in slave                      |
| `apb_b2b_read_test`             | Multiple consecutive reads from valid locations               | Returned data matches memory contents                         |
| `apb_pready_delay_test`         | Insert wait cycles before `PREADY` is asserted                | Master waits and resumes without timing violations            |
| `apb_pslverr_test`              | Simulate slave error response via `PSLVERR`                   | Master terminates transaction or reports error                |
| `apb_invalid_address_test`      | Access address beyond valid memory map                        | Slave ignores or flags error; system remains stable           |
| `apb_mixed_rw_test`            | Alternate between write and read operations                   | Each transaction is isolated and behaves correctly            |
| `apb_reset_mid_transfer_test`   | Assert reset during active transfer                           | Master FSM recovers cleanly; no hanging `PSEL`/`PENABLE`      |

---

