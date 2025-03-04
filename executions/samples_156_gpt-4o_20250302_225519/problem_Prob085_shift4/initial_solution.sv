module TopModule (
    input  logic clk,         // Clock signal, active on the positive edge
    input  logic areset,      // Asynchronous active-high reset
    input  logic load,        // Synchronous active-high load control
    input  logic ena,         // Synchronous active-high enable for shifting
    input  logic [3:0] data,  // 4-bit wide data input
    output logic [3:0] q      // 4-bit wide shift register output
);

always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
        q <= 4'b0000;
    end else if (load) begin
        q <= data;
    end else if (ena) begin
        q <= {1'b0, q[3:1]};
    end
end

endmodule