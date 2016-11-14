`ifndef DRIVER_SV
`define DRIVER_SV

`include "command.sv"

class Driver;
  mailbox gen2drv;
  event drv2gen;
  virtual Port_ifc.Driver port_ifc;
  int port;

  extern function new(
      input mailbox gen2drv,
      input event drv2gen, 
      virtual Port_ifc.Driver port_ifc,
      int port);
  extern task run();
endclass : Driver

function Driver::new(
    input mailbox gen2drv,
    input event drv2gen, 
    virtual Port_ifc.Driver port_ifc,
    int port);
  this.gen2drv = gen2drv;
  this.drv2gen = drv2gen;
  this.port_ifc = port_ifc;
  this.port = port;
endfunction : new

task Driver::run();
  Command command;

  port_ifc.cbd.data_in <= 0;
  port_ifc.cbd.cmd_in <= 0;
  port_ifc.cbd.tag_in <= 0;

  forever begin
    gen2drv.peek(command);

    $display("[port %1d] Command in: cmd = %b, operands = %b (%d), %b (%d), tag = %b",
        port, command.cmd, command.data1, command.data1, command.data2, command.data2,
        command.tag);
    
    @(port_ifc.cbd);
    port_ifc.cbd.cmd_in <= command.cmd; 
    port_ifc.cbd.data_in <= command.data1;
    port_ifc.cbd.tag_in <= command.tag;
    @(port_ifc.cbd);
    port_ifc.cbd.cmd_in <= 0;
    port_ifc.cbd.data_in <= command.data2;
    port_ifc.cbd.tag_in <= 0;
    @(port_ifc.cbd);
    port_ifc.cbd.data_in <= 0;

    gen2drv.get(command);
    ->drv2gen;
  end
endtask : run

`endif