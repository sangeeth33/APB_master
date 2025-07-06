class apb_pslverr_test extends apb_base_test;
  `uvm_component_utils(apb_pslverr_test)

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    env.agent.vif.inject_error = 1; // Error injection signal
    apb_transaction txn = apb_transaction::type_id::create("txn");
    txn.addr  = 32'h0000_0044;
    txn.data  = 32'hDEADBEEF;
    txn.write = 1;
    env.agent.sequencer.start_item(txn);
    env.agent.sequencer.finish_item(txn);
    phase.drop_objection(this);
  endtask
endclass