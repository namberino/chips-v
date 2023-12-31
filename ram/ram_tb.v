`timescale 1 ns / 10 ps

module main;
  reg clk, we;
  reg [5:0] rwaddr;
  reg [15:0] di;
  wire [15:0] do;
  
  ram uut ( 
    .clk(clk),
    .we(we),
    .rwaddr(rwaddr),
    .di(di),
    .do(do)
  );
  
  // clock pulse starts from 1
  initial 
    clk = 1'b1;
  always
    #25 clk = ~clk;
    
  // data stimulus
  initial 
  begin
    #1  we = 1'b0; rwaddr = 6'h2A; di = 16'hCAFE;
    #50 we = 1'b1; rwaddr = 6'h2A; di = 16'hCAFE;
    #50 we = 1'b0; rwaddr = 6'h2A; di = 16'hCAFE;
    #50 we = 1'b0; rwaddr = 6'h3A; di = 16'hDEED;
    #50 we = 1'b0; rwaddr = 6'h3A; di = 16'hDEED;
    #50 we = 1'b0; rwaddr = 6'h3A; di = 16'hDEED;
    #50 we = 1'b0; rwaddr = 6'h2A; di = 16'hCAFE;
    #50 we = 1'b1; rwaddr = 6'h2A; di = 16'hCAFE;
    #50
//    $stop;    // for Modelsim
    $finish;  // for Icarus Verilog
  end
  
  initial
    $monitor("%t: clk = %b, we=%b, rwaddr=%h, di=%h, do=%h", 
    $time, clk, we, rwaddr, di, do);

  initial 
  begin
    // open a VCD file for writing
    $dumpfile("ram.vcd");
    // dump the values of all nets and wires in module "main", since simulation
    // time 0
    $dumpvars(0, main);
  end

endmodule
