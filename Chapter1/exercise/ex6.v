
module testbench();
wire clk,a,b,start,sum;
clk_gen          d1(clk);
test_serialAdder d2(a,b,start,sum);
serialAdder      d3(clk,a,b,start,sum);

initial begin
  $dumpfile("ex6.vcd");
  $dumpvars(0, testbench);
end
endmodule

module clk_gen(
  output reg clk
);
initial #1 clk = 1;
always  #5 clk = ~clk;
endmodule

module test_serialAdder(
  output reg a, b, start,
  input sum
);

initial begin
  $monitor($time,, "%b %b %b", a, b, sum);
  // 01101010 + 01101011 = 11010101
  #1  start = 1; a = 0; b = 1;
  #10 start = 0; a = 1; b = 1;
  #10 start = 0; a = 0; b = 0;
  #10 start = 0; a = 1; b = 1;
  #10 start = 0; a = 0; b = 0;
  #10 start = 0; a = 1; b = 1;
  #10 start = 0; a = 1; b = 1;
  #10 start = 0; a = 0; b = 0;
  #10 $finish;
end
endmodule

module serialAdder(
  input clk, a, b, start,
  output reg sum);

reg carry;

always @(negedge clk) begin
  if (start) {carry, sum} <= a + b;
  else {carry, sum} <= a + b + carry;
end

endmodule
