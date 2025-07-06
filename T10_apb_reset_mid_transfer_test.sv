class apb_reset_mid_transfer_test extends apb_base_test;
  `uvm_component_utils(apb_reset_mid_transfer_test)

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    apb_transaction txn = apb_transaction::type_id::create("txn_reset");
    txn.addr  = 32'h0000_0100;
    txn.data  = 32'h12345678;
    txn.write = 1;
    env.agent.sequencer.start_item(txn);
    #5;
    env.agent.vif.PRESETn <= 0;
    #10;
    env.agent.vif.PRESETn <= 1;
    env.agent.sequencer.finish_item(txn);
    phase.drop_objection(this);
  endtask
endclass