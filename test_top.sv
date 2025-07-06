module test_top;
  bit PCLK = 0;
  bit PRESETn;

  apb_if apb_vif(PCLK, PRESETn);

  initial forever #5 PCLK = ~PCLK;

  initial begin
    PRESETn = 0;
    #15;
    PRESETn = 1;
  end

  initial begin
    uvm_config_db#(virtual apb_if)::set(null, "*", "vif", apb_vif);
    run_test("apb_base_test");
  end
endmodule