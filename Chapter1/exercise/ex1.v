module testBench;
wire w1,w2,w3,w4,w5;
binaryToESeg d (w1,w2,w3,w4,w5);
test_bToESeg t (w1,w2,w3,w4,w5);
endmodule

module binaryToESeg(input A,B,C,D, output eSeg);

//nand #1
//    g1 (p1,C,~D),
//    g2 (p2,A,B),
//    g3 (p3,~B,~D),
//    g4 (p4,A,C),
//    g5 (eSeg,p1,p2,p3,p4);
wire p1,p2,p3,p4;
assign #1 p1 = ~(C & ~D);
assign #1 p2 = ~(A & B);
assign #1 p3 = ~(~B & ~D);
assign #1 p4 = ~(A & C);
assign #1 eSeg = ~ (p1 & p2 & p3 & p4);
endmodule


module test_bToESeg(output reg A,B,C,D, input eSeg);
initial begin
  $monitor($time,,"A = %b B = %b C = %b D = %b, eSeg = %b",A,B,C,D,eSeg);

  // Waveform for simulating the nand filp flop
  #10 A = 0; B = 0; C = 0; D = 0;
  #10 D = 1;
  #10 C = 1; D = 0;
  #10 $finish;
end
endmodule
