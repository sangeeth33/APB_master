class apb_driver extends uvm_driver #(apb_transaction);

  `uvm_component_utils(apb_driver)

  virtual apb_if vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    apb_transaction txn;

    forever begin
      seq_item_port.get_next_item(txn);
      
      vif.PADDR   <= txn.addr;
      vif.PWRITE  <= txn.write;
      vif.PWDATA  <= txn.data;
      vif.PSEL    <= 1;
      vif.PENABLE <= 0;

      @(posedge vif.PCLK);
      vif.PENABLE <= 1;

      @(posedge vif.PCLK);
      wait(vif.PREADY);

      if (!txn.write)
        txn.read_data = vif.PRDATA;

      vif.PSEL    <= 0;
      vif.PENABLE <= 0;

      seq_item_port.item_done();
    end
  endtask
endclass