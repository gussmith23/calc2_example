`ifndef SCOREBOARD_SV
`define SCOREBOARD_SV

`include "result.sv"
`include "driver.sv"
`include "command.sv"
`include "monitor.sv"

class Scoreboard;
  Result add_queue[$], shift_queue[$];
  extern function new();
  extern function void save_expected(Driver driver, Command command);
  extern function void check_actual(Monitor monitor, Result result);
endclass

function Scoreboard::new();
endfunction

function void Scoreboard::save_expected(Driver driver, Command command);
  $display("[port %1d] Command in: cmd = %b, operands = %b (%d), %b (%d), tag = %b",
      driver.port, command.cmd, command.data1, command.data1, command.data2, command.data2,
      command.tag);
endfunction

function void Scoreboard::check_actual(Monitor monitor, Result result);
  $display("[port %1.d] Result out: resp = %b, data = %b (%d), tag = %b",
      monitor.port, result.resp, result.data, result.data, result.tag);
endfunction

`endif
