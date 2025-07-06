class apb_transaction extends uvm_sequence_item;
  rand bit        write;
  rand bit [31:0] addr;
  rand bit [31:0] data;

  bit [31:0]      read_data;

  `uvm_object_utils(apb_transaction)

  function new(string name = "apb_transaction");
    super.new(name);
  endfunction

  function void do_print(uvm_printer printer);
    super.do_print(printer);
    `uvm_info("TXN", $sformatf("WRITE:%0d ADDR:0x%08h DATA:0x%08h READ_DATA:0x%08h", write, addr, data, read_data), UVM_MEDIUM)
  endfunction
endclass