class apb_monitor extends uvm_monitor;

  `uvm_component_utils(apb_monitor)
  virtual apb_if vif;
  uvm_analysis_port #(apb_transaction) ap;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    ap = new("ap", this);
  endfunction

  task run_phase(uvm_phase phase);
    forever begin
      @(posedge vif.PCLK);
      if (vif.PSEL && vif.PENABLE && vif.PREADY) begin
        apb_transaction txn = apb_transaction::type_id::create("txn");
        txn.addr      = vif.PADDR;
        txn.write     = vif.PWRITE;
        txn.data      = vif.PWDATA;
        txn.read_data = vif.PRDATA;
        ap.write(txn);
      end
    end
  endtask
endclass