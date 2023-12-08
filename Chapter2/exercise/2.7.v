

module B(
  input clk, rst,
  input Ain, Bin,
  output reg y
);

reg [1:0] curState, nxtState;

always @(posedge clk, negedge rst) begin
  if (~rst) curState <= 2'b00;
  else      curState <= nxtState;
end

endmodule
