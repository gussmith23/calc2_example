`ifndef GENERATOR_SV
`define GENERATOR_SV

`include "command.sv"

class Generator;
  mailbox gen2drv;
  event drv2gen;
  extern function new(
    input mailbox gen2drv,
    input event drv2gen);
  extern task run();
endclass : Generator

function Generator::new(input mailbox gen2drv, input event drv2gen);
  this.gen2drv = gen2drv;
  this.drv2gen = drv2gen;
endfunction : new

task Generator::run();
  Command command = new(1, 1, 1, 0);  
  gen2drv.put(command);
  @drv2gen;
endtask : run

`endif
