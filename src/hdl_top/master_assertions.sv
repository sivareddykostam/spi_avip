//--------------------------------------------------------------------------------------------
// Module : Master Assertions
// Used to write the assertion checks needed for the master
//--------------------------------------------------------------------------------------------
`ifndef MASTER_ASSERTIONS_INCLUDED_
`define MASTER_ASSERTIONS_INCLUDED_

  //-------------------------------------------------------
  // Importing Uvm Package
  //-------------------------------------------------------
  import spi_globals_pkg::*;

interface master_assertions ( input pclk,
                              input areset,
                              input sclk,
                              input [NO_OF_SLAVES-1:0] cs,
                              input mosi0,
                              input mosi1,
                              input mosi2,
                              input mosi3,
                              input miso0,
                              input miso1,
                              input miso2,
                              input miso3 );

  bit [1:0]spi_type;

  //-------------------------------------------------------
  // Importing Uvm Package
  //-------------------------------------------------------
  import uvm_pkg::*;
  `include "uvm_macros.svh";

  initial begin
    `uvm_info("MASTER_ASSERTIONS","MASTER ASSERTIONS",UVM_LOW);
    `uvm_info("Master_Assertions_TB_TEST",$sformatf("cs=%0d,sclk=%0d,mosi0=%d,miso0=%d",cs,sclk,mosi0,miso0),UVM_LOW);
  end
  
  // Assertion for if_signals_are_stable
  // When cs is high, the signals sclk, mosi, miso should be stable.
  property if_signals_are_stable(logic mosi_local, logic miso_local);
    @(posedge pclk)  
    //@(posedge pclk) disable iff(areset==0)
    //cs == '1 |-> $stable(sclk) && $stable(mosi0) && $stable(miso0);
    cs=='1  |-> $stable(sclk) && $stable(mosi_local) && $stable(miso_local);
    //cs == '1 |-> mosi0 ==1'b0;
  endproperty : if_signals_are_stable

/*
  // Assertion for master_mosi0_valid
  // when cs is low mosi should be valid from next clock cycle.
  sequence master_mosi0_valid_seq;
    cs==0;
  endsequence : master_mosi0_valid_seq

  property master_mosi0_valid_p;
    @(posedge sclk) disable iff(!areset)
    master_mosi0_valid_seq |-> !$isunknown(mosi0);
  endproperty : master_mosi0_valid_p
  MASTER_CS_LOW_CHECK: assert property (master_mosi0_valid_p);
  

  // Assertion for if_cs_is_stable_during_transfers
  // cs should be low and stable till data transfer is successful ($stable)
  sequence if_cs_is_stable_during_transfers_s1;
    @(posedge sclk)
    cs == 0;
  endsequence:if_cs_is_stable_during_transfers_s1

  sequence if_cs_is_stable_during_transfers_s2;
    @(posedge sclk)
    $stable(cs)[*8];
  endsequence:if_cs_is_stable_during_transfers_s2

  property if_cs_is_stable_during_transfers;
    @(posedge sclk) disable iff(!areset)
    if_cs_is_stable_during_transfers_s1 |-> if_cs_is_stable_during_transfers_s2;
  endproperty:if_cs_is_stable_during_transfers
  IF_CS_IS_STABLE_DURING_TRANSFERS: assert property (if_cs_is_stable_during_transfers);

 
  // Assertion for successful_data_transfers
  // cs should be low for multiples of 8 clock cycles for successful data transfer
   sequence successful_data_transfers_s1;
    @(posedge sclk)
    (!cs && !$isunknown(mosi0))[*8];
  endsequence:successful_data_transfers_s1

  property successful_data_transfers;
    @(posedge sclk) disable iff(!areset)
    successful_data_transfers_s1;
  endproperty:successful_data_transfers
  SUCCESSFUL_DATA_TRANSFERS: assert property (successful_data_transfers);

*/
 
  `ifdef spi_type==2'd0
    IF_SIGNALS_ARE_STABLE_SINGLE_SPI: assert property (if_signals_are_stable(mosi0,miso0));
  `endif
/*  `ifdef(spi_type == 2'd1) begin
    IF_SIGNALS_ARE_STABLE_DUAL_SPI_1: assert property (if_signals_are_stable(mosi0,miso0));
    IF_SIGNALS_ARE_STABLE_DUAL_SPI_2: assert property (if_signals_are_stable(mosi1,miso1));
  end
  `endif
  `ifdef(spi_type == 2'd2) begin
    IF_SIGNALS_ARE_STABLE_QUAD_SPI_1: assert property (if_signals_are_stable(mosi0,miso0));
    IF_SIGNALS_ARE_STABLE_QUAD_SPI_2: assert property (if_signals_are_stable(mosi1,miso1));
    IF_SIGNALS_ARE_STABLE_QUAD_SPI_3: assert property (if_signals_are_stable(mosi2,miso2));
    IF_SIGNALS_ARE_STABLE_QUAD_SPI_4: assert property (if_signals_are_stable(mosi3,miso3));
  end
`endif
*/
endinterface : master_assertions

`endif
