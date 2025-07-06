class apb_invalid_address_test extends apb_base_test;
  `uvm_component_utils(apb_invalid_address_test)

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    apb_transaction txn = apb_transaction::type_id::create("txn");
    txn.addr  = 32'hFFFF_FFFF; // Out of bounds
    txn.write = 0;
    env.agent.sequencer.start_item(txn);
    env.agent.sequencer.finish_item(txn);
    phase.drop_objection(this);
  endtask
endclass