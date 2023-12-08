

module TestBench #(parameter WIDTH = 4)();

wire [WIDTH-1:0] A, B, Out;
wire [1:0] AddSel;

Test_SatuationAdder #(WIDTH) ts(A, B, AddSel, Out);
SaturationAdder     #(WIDTH) sa(A, B, AddSel, Out);

endmodule

module Test_SatuationAdder #(parameter WIDTH = 4)(
  output reg [WIDTH-1:0]  A, B,
  output reg [1:0]        AddSel,
  input      [WIDTH-1:0]  Out
);

integer i, j, k;
initial begin
  $monitor($time,, "%d | %d %d = %d", AddSel, A, B, Out);
  for (i = 0; i < 4; i = i + 1) begin
    for (j = 0; j < 16; j = j + 1) begin
      for (k = 0; k < 16; k = k + 1) begin
        #10 AddSel = i;
        A = j;
        B = k;
      end
    end
  end

  #10 $finish;
end
endmodule

module SaturationAdder #(parameter WIDTH = 4)(
  input       [WIDTH-1:0] A, B,
  input       [1:0] AddSel,
  output reg  [WIDTH-1:0] Out
);

wire [WIDTH-1:0] CB;
wire [WIDTH:0] actualAdd;
wire [WIDTH-1:0] Min, Max;

assign CB = (AddSel[0] == 1'b1) ? B^{(WIDTH){1'b1}}+1'b1 : B^{(WIDTH){1'b0}};
assign actualAdd = A + CB;
assign Min = {1'b1, {(WIDTH){1'b0}}};
assign Max = {1'b0, {(WIDTH){1'b1}}};

always @(*) begin
  Out = A + CB;
  if (AddSel[1] == 1'b1) begin
    if (A[WIDTH-1] == 1'b0 & B[WIDTH-1] == 1'b0) begin
      if (actualAdd > Max) Out = Max;
    end else if (A[WIDTH-1] == 1'b1 & B[WIDTH-1] == 1'b1) begin
      if (actualAdd < Min) Out = Min;
    end
  end
end
endmodule
