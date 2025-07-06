class apb_pready_delay_test extends apb_base_test;
  `uvm_component_utils(apb_pready_delay_test)

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    env.agent.vif.delayed_pready_cycles = 3; // Add this field to the interface for delay control
    apb_sequence seq = apb_sequence::type_id::create("seq");
    seq.start(env.agent.sequencer);
    phase.drop_objection(this);
  endtask
endclass