


// A target computation
// for (x = 0, i = 0; i <= 10; i = i + 1)
//   x = x + y;
// 
// if (x < 0)  y = 0;
// else        x = 0;


module computation(
  input clock, reset,
  output [7:0] outRegI, outRegX, outRegY 
);

wire [7:0] outAdder1, outAdder2;
FSM fsm(clock, reset, ILTE10, XLT0, iLoad, iClear, xLoad, xClear, yLoad, yClear);
REGISTER i(iLoad, iClear, outAdder1, outRegI);
REGISTER x(xLoad, xClear, outAdder2, outRegX);
REGISTER y(yLoad, yClear, 8'b00000011,      outRegY);

ADDER adder1(8'b00000001, outRegI, outAdder1),
      adder2(outRegX, outRegY, outAdder2);
LT lt(8'b00000000, outRegX, XLT0);
LTE lte(8'b00001010, outRegI, ILTE10);
endmodule

module FSM(
  input clock, reset,
  input ILTE10, XLT0,
  output reg iLoad, iClear, xLoad, xClear, yLoad, yClear
);

reg [2:0] currentState, nextState;
localparam [2:0] A = 3'b000,
                 B = 3'b001,
                 C = 3'b010,
                 D = 3'b011,
                 E = 3'b100,
                 F = 3'b101;

 always @(*) begin
  iLoad   = 1'b1;
  iClear  = 1'b1;  
  xLoad   = 1'b1;
  xClear  = 1'b1;
  yLoad   = 1'b1;
  yClear  = 1'b1;

   case (currentState)
     A: begin
       iLoad   = 1'b1;
       iClear  = 1'b0;  
       xLoad   = 1'b1;
       xClear  = 1'b0;
       yLoad   = 1'b1;
       yClear  = 1'b1;
       nextState = B;
     end
     B: begin
       iLoad   = 1'b0;
       iClear  = 1'b1;  
       xLoad   = 1'b0;
       xClear  = 1'b1;
       yLoad   = 1'b1;
       yClear  = 1'b1;
       nextState = C;
     end
     C: begin
       iLoad   = 1'b1;
       iClear  = 1'b1;  
       xLoad   = 1'b1;
       xClear  = 1'b1;
       yLoad   = 1'b1;
       yClear  = 1'b1;
       if (ILTE10) nextState = B;
       if (~ILTE10 & XLT0) nextState = D;
       if (~ILTE10 & ~XLT0) nextState = E;
     end
     D: begin
       iLoad   = 1'b1;
       iClear  = 1'b1;  
       xLoad   = 1'b1;
       xClear  = 1'b1;
       yLoad   = 1'b1;
       yClear  = 1'b0;
       nextState = F;
     end
     E: begin
       iLoad   = 1'b1;
       iClear  = 1'b1;  
       xLoad   = 1'b1;
       xClear  = 1'b0;
       yLoad   = 1'b1;
       yClear  = 1'b1;
       nextState = F;
     end
     E: begin
       iLoad   = 1'b1;
       iClear  = 1'b1;  
       xLoad   = 1'b1;
       xClear  = 1'b1;
       yLoad   = 1'b1;
       yClear  = 1'b1;
       nextState = F;
     end
     default: begin
       iLoad   = 1'b1;
       iClear  = 1'b1;  
       xLoad   = 1'b1;
       xClear  = 1'b1;
       yLoad   = 1'b1;
       yClear  = 1'b1;
       nextState = 3'bxxx;
     end
   endcase
 end

 always @(posedge clock or negedge reset) begin
   if (~reset) currentState <= A;
   else currentState <= nextState;
 end
endmodule

module REGISTER(
  input             clock, load, clear, // both active low
  input       [7:0] dataIn,
  output reg  [7:0] dataOut);

// Inffered Flip Flop
always @(posedge clock) begin
  if (~clear) dataOut <= 0;
  else if (~load) dataOut <= dataIn;
end
endmodule

module ADDER(
  input  [7:0] in1, in2,
  output [7:0] out
);
assign out = in1 + in2;
endmodule 

module LT(
  input [7:0] in1, in2,
  output out
);
assign out = in1 < in2;
endmodule


module LTE(
  input [7:0] in1, in2,
  output out
);
assign out = in1 <= in2;
endmodule


