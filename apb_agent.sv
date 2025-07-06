class apb_agent extends uvm_agent;

  `uvm_component_utils(apb_agent)

  apb_sequencer sequencer;
  apb_driver    driver;
  apb_monitor   monitor;

  virtual apb_if vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    sequencer = apb_sequencer::type_id::create("sequencer", this);
    driver    = apb_driver::type_id::create("driver", this);
    monitor   = apb_monitor::type_id::create("monitor", this);

    driver.vif  = vif;
    monitor.vif = vif;
  endfunction
endclass