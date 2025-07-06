class apb_sequence extends uvm_sequence #(apb_transaction);

  `uvm_object_utils(apb_sequence)

  function new(string name = "apb_sequence");
    super.new(name);
  endfunction

  task body();
    apb_transaction txn;

    // Write Transaction
    txn = apb_transaction::type_id::create("txn_write");
    txn.addr = 32'h0000_0004;
    txn.data = 32'hA5A5_5A5A;
    txn.write = 1;
    start_item(txn);
    finish_item(txn);

    // Read Transaction
    txn = apb_transaction::type_id::create("txn_read");
    txn.addr = 32'h0000_0004;
    txn.write = 0;
    start_item(txn);
    finish_item(txn);
  endtask
endclass