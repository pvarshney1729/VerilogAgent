module TopModule (
    input  logic clk,
    input  logic reset,
    output logic [31:0] q
);
    // Internal signal to hold the next state of the LFSR
    logic [31:0] next_q;

    // Combinational logic for the next state of the LFSR
    always @(*) begin
        next_q = {q[30:0], (q[31] ^ q[21] ^ q[1] ^ q[0])}; // XOR tap positions
    end

    // Synchronous reset and state update
    always @(posedge clk) begin
        if (reset) begin
            q <= 32'h00000001; // Reset value
        end else begin
            q <= next_q; // Update state
        end
    end
endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly