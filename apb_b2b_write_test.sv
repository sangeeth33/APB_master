class apb_b2b_write_test extends apb_base_test;
  `uvm_component_utils(apb_b2b_write_test)

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    foreach (int i in {0,1,2}) begin
      apb_transaction txn = apb_transaction::type_id::create($sformatf("txn_write_%0d", i));
      txn.addr  = 32'h0000_0010 + i*4;
      txn.data  = $urandom;
      txn.write = 1;
      env.agent.sequencer.start_item(txn);
      env.agent.sequencer.finish_item(txn);
    end
    phase.drop_objection(this);
  endtask
endclass