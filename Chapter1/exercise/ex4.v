module testbench;
wire clock1, clock2;
two_phase dut(clock1, clock2);

initial begin
  $dumpfile("ex4.vcd");
  $dumpvars(0, testbench);
  $monitor($time,,,"%d %d", clock1, clock2);
  #1000 $finish;
end
endmodule


module two_phase(output reg clock1, clock2);

initial begin
  #5 clock1 = 1;
  #5 clock2 = 1;
end

always begin
  #100 clock1 = ~clock1;
  #40  clock2 = ~clock2;
end
endmodule
