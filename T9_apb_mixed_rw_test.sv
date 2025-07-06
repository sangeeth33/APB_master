class apb_mixed_rw_test extends apb_base_test;
  `uvm_component_utils(apb_mixed_rw_test)

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    for (int i = 0; i < 3; i++) begin
      apb_transaction txn = apb_transaction::type_id::create($sformatf("txn_%0d", i));
      txn.addr  = 32'h0000_0080 + i*4;
      txn.data  = $urandom;
      txn.write = (i % 2 == 0);
      env.agent.sequencer.start_item(txn);
      env.agent.sequencer.finish_item(txn);
    end
    phase.drop_objection(this);
  endtask
endclass