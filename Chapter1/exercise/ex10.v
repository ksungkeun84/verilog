module testbench();

test_bad_timing d1(f_out,a,b,c);
bad_timing d2(f_out,a,b,c);

initial begin
  $dumpfile("ex10.vcd");
  $dumpvars(0, testbench);
end
endmodule

module test_bad_timing(
  input f_out,
  output reg a,b,c
);

initial begin
  $monitor($time,, "%b %b %b | %b", a,b,c,f_out);
  a = 0; b = 0; c = 1;
  #21 c = 0;
  #50 $finish;
end
endmodule


module bad_timing(
  output f_out,
  input a,b,c
);

nand #10
    g1(f1,a,b),
    g2(f_out,f1,c);
endmodule
