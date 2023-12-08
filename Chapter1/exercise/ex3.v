module m555 (output reg clock);

initial
  #5 clock = 1;

always begin
  #60 clock = ~clock;
  #40 clocl = ~clocl;
end
endmodule
