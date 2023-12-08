

module Testbench();

Test_HW_Design_Survivor d1(rat, non_VHDL_alliance, immunity1, immunity2, naked, survivor);
HW_Design_Survivor d2(rat, non_VHDL_alliance, immunity1, immunity2, naked, survivor);
endmodule


module Test_HW_Design_Survivor(
  output reg rat, non_VHDL_alliance, immunity1, immunity2, naked,
  input survivor
);
integer i;
initial begin
  $monitor($time,, "%b %b %b %b %b | %b", rat, non_VHDL_alliance, immunity1, immunity2, naked, survivor);
  for (i = 0; i < 32; i = i + 1) begin
    #1 {rat, non_VHDL_alliance, immunity1, immunity2, naked} = i;
  end
    #1 $finish;
end
endmodule

module HW_Design_Survivor(
  input rat, non_VHDL_alliance, immunity1, immunity2, naked,
  output survivor
);

AND d1(out_and1, rat, non_VHDL_alliance);
AND d2(out_and2, immunity1, immunity2);
NOT d3(out_not, naked);
AND d4(out_and3, out_and2, out_not);
OR  d5(survivor, out_and1, out_and3);
endmodule

module AND(output out, input a, b);
nand d1(out_d1, a, b);
nand d2(out, out_d1, out_d1);
endmodule

module OR(output out, input a, b);
nand d1(out_d1, a, a);
nand d2(out_d2, b, b);
nand d3(out, out_d1, out_d2);
endmodule

module NOT(output out, input a);
nand (out, a,a);
endmodule
