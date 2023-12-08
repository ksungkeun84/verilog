// Write three different descriptions of a 2-bit full adder including carry-in and carry-out ports.
// One description should use gate-level modesl, another should use continuous assignment statements,
// and the third -- combinational always.


module testbench;
wire in1, in0, cin, out1, cout1, out2, cout2, out3, cout3;
fulladder_2b_gate d1(in1, in0, cin, out1, cout1);
fulladder_2b_ca   d2(in1, in0, cin, out2, cout2);
fulladder_2b_b    d3(in1, in0, cin, out3, cout3);
test_fulladder_2b t (in1, in0, cin, out1, cout1, out2, cout2, out3, cout3);
endmodule

module fulladder_2b_gate (input in1, in0, cin, output out, cout);
wire w1,w2,w3;
xor  g1 (w1,   in1, in0);
xor  g2 (out,  w1,  cin);
nand g3 (w2,   in1, in0);
nand g4 (w3,   w1,  cin);
nand g5 (cout, w2,  w3);
endmodule

module fulladder_2b_ca (input in1, in0, cin, output out, cout);
assign {cout, out} = in1 + in0 + cin;
endmodule

module fulladder_2b_b (input in1, in0, cin, output reg out, cout);
always @(in1,in0,cin) begin
  {cout, out} = in1 + in0 + cin;
end
endmodule


module test_fulladder_2b(output reg in1, in0, cin, input out1, cout1, out2, cout2, out3, cout3);
initial begin
  $monitor($time,, "%b %b %b | %b %b %b %b %b %b", in1, in0, cin, out1, cout1, out2, cout2, out3, cout3);
  #10 in1 = 0; in0 = 0; cin = 0;
  #10 in1 = 0; in0 = 0; cin = 1;
  #10 in1 = 0; in0 = 1; cin = 0;
  #10 in1 = 0; in0 = 1; cin = 1;
  #10 in1 = 1; in0 = 0; cin = 0;
  #10 in1 = 1; in0 = 0; cin = 1;
  #10 in1 = 1; in0 = 1; cin = 0;
  #10 in1 = 1; in0 = 1; cin = 1;
  #10 $finish;
end
endmodule
