
module TestBench();

Test_Satisfaction_Detector_II d1(Has_Money, Has_Power, Has_Fame, Going_To_Die, Keeps_on_Trying, Has_Satisfaction);
Satisfaction_Detector_II      d2(Has_Money, Has_Power, Has_Fame, Going_To_Die, Keeps_on_Trying, Has_Satisfaction);
endmodule



module Test_Satisfaction_Detector_II (
  output reg Has_Money, Has_Power, Has_Fame, Going_To_Die, Keeps_on_Trying,
  input Has_Satisfaction
);

integer i;
initial begin
  $monitor($time,, "%b %b %b %b %b | %b",
    Has_Money, Has_Power, Has_Fame, Going_To_Die, Keeps_on_Trying, Has_Satisfaction);
  for (i = 0; i < 32; i=i+1)
    #10 {Has_Money, Has_Power, Has_Fame, Going_To_Die, Keeps_on_Trying} = i;
  #10 $finish;
end
endmodule

module Satisfaction_Detector_II (
  input Has_Money, Has_Power, Has_Fame, Going_To_Die, Keeps_on_Trying,
  output reg Has_Satisfaction
);

always @(*) begin
  Has_Satisfaction = Has_Money | Has_Power | Has_Fame;
  if (Keeps_on_Trying) Has_Satisfaction = 1'b1;
  else if (Going_To_Die) Has_Satisfaction = 1'b0;
end

endmodule
