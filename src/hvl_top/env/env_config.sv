`ifndef ENV_CONFIG_INCLUDED_
`define ENV_CONFIG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: env_config
// Used for setting various configurations for the environment
//--------------------------------------------------------------------------------------------
class env_config extends uvm_object;
  `uvm_object_utils(env_config)
  
    int no_of_magent = 1;
    int no_of_sagent = 1;
   
    master_agent_config ma_cfg_h[];
    slave_agent_config sa_cfg_h[];
    bit has_m_agt;
    bit has_s_agt;
  
  // Variable: has_scoreboard
  // Enables the scoreboard. Default value is 1
  bit has_scoreboard = 1;

  // Variable: has_virtual_sqr
  // Enables the virtual sequencer. Default value is 1
  bit has_virtual_sqr = 1;

  // Variable: no_of_slaves
  // Number of slaves connected to the SPI interface
  int no_of_slaves;

  // Variable: ma_cfg_h
  // Handle for master agent configuration

  // Variable: sa_cfg_h
  // Dynamic array of slave agnet configuration handles

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "env_config");
endclass : env_config

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - env_config
//--------------------------------------------------------------------------------------------
function env_config::new(string name = "env_config");
  super.new(name);
endfunction : new

`endif

