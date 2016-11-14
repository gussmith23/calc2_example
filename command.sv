`ifndef COMMAND_SV
`define COMMAND_SV

class Command;
  logic [0:3] cmd;
  logic [0:31] data1, data2;
  logic [0:1] tag;
  // The number of cycles the driver should wait between issuing the previous
  // instruction and issuing this instruction.
  int unsigned cycle_delay;
  int unsigned port;

  function new(logic [0:3] cmd, logic [0:31] data1, data2,
                logic [0:1] tag, int unsigned cycle_delay, int unsigned port);
    this.cmd = cmd;
    this.data1 = data1;
    this.data2 = data2;
    this.tag = tag;
    this.cycle_delay = cycle_delay;
    this.port = port;
  endfunction : new

endclass : Command
  
`endif
