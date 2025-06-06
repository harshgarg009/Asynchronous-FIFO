`timescale 1ns / 1ps
module fifo_mem 
#(
  parameter WIDTH = 4,
  parameter DEPTH = 8
)
(
  input wire w_clk,r_clk,
  input wire wr_rq,
  input wire rd_rq,
  input wire full,
  input wire empty,
  input wire [$clog2(DEPTH)-1:0] waddr,
  input wire [$clog2(DEPTH)-1:0] raddr,
  input wire [WIDTH-1:0] wdata,
  output reg [WIDTH-1:0] rdata
);

reg [WIDTH-1:0] fifo [0:DEPTH-1];


always @(posedge w_clk) begin
    if (wr_rq && !full) begin
      fifo[waddr] <= wdata;
    end
end
always @(posedge r_clk) begin
    if (rd_rq && !empty) begin
      rdata <= fifo[raddr];
    end else begin
      rdata = {WIDTH{1'b0}};
    end
end

endmodule
