module testbench();
  test_the_ckt d(f,a,b,c,d);
  the_ckt      d2(f,a,b,c,d);

initial begin
  $dumpfile("ex8.vcd");
  $dumpvars(0, testbench);
end
endmodule

module test_the_ckt(
  input f,
  output reg a,b,c,d);

integer i;
initial begin
  $monitor($time,, "%b %b %b %b | %b", a,b,c,d,f);
  for (i = 0; i < 16; i=i+1) begin
    #1 {a,b,c,d} = i;
  end

end
endmodule

module the_ckt(
  output f,
  input a,b,c,d);
and (f3,f1,d),
  (f4,f2,b);
xnor(f1,a,c);
not(f2,f1);
or(f,f3,f4);
endmodule
