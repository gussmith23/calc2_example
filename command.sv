`ifndef COMMAND_SV
`define COMMAND_SV

class Command;
  logic [0:3] cmd;
  logic [0:31] data1, data2;
  logic [0:1] tag;
  time time_inserted;
  // The number of cycles the driver should wait between issuing the previous
  // instruction and issuing this instruction.
  int unsigned cycle_delay;
  int unsigned port;

  function new(logic [0:3] cmd, logic [0:31] data1, data2,
                int unsigned cycle_delay);
    this.cmd = cmd;
    this.data1 = data1;
    this.data2 = data2;
    this.tag = -1;
    this.cycle_delay = cycle_delay;
    this.port = -1;
    this.time_inserted = -1;
  endfunction : new

endclass : Command
  
`endif
