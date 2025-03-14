[BEGIN]
module TopModule(
    input logic clk,           // Clock signal, positive edge-triggered
    input logic areset,        // Asynchronous active-high reset
    input logic load,          // Synchronous active-high load control
    input logic ena,           // Synchronous active-high enable for shifting
    input logic [3:0] data,    // 4-bit data input, unsigned
    output logic [3:0] q       // 4-bit shift register output, unsigned
);

logic [3:0] next_q;

// Combinational logic to determine the next state
always_comb begin
    if (areset) begin
        next_q = 4'b0000;
    end else if (load) begin
        next_q = data;
    end else if (ena) begin
        next_q = {1'b0, q[3:1]};
    end else begin
        next_q = q;
    end
end

// Sequential logic to update the state on the clock edge
always_ff @(posedge clk) begin
    q <= next_q;
end

endmodule
[DONE]