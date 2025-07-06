class apb_scoreboard extends uvm_component;

  `uvm_component_utils(apb_scoreboard)
  uvm_analysis_imp #(apb_transaction, apb_scoreboard) monitor_imp;

  bit [31:0] apb_mem [0:255];

  function new(string name, uvm_component parent);
    super.new(name, parent);
    monitor_imp = new("monitor_imp", this);
  endfunction

  function void write(apb_transaction txn);
    if (txn.write) begin
      apb_mem[txn.addr[9:2]] = txn.data;
    end else begin
      if (txn.read_data !== apb_mem[txn.addr[9:2]]) begin
        `uvm_error("SCOREBOARD", $sformatf("Read mismatch at 0x%08h: expected 0x%08h, got 0x%08h",
          txn.addr, apb_mem[txn.addr[9:2]], txn.read_data))
      end else begin
        `uvm_info("SCOREBOARD", $sformatf("Read matches: 0x%08h", txn.read_data), UVM_MEDIUM)
      end
    end
  endfunction
endclass