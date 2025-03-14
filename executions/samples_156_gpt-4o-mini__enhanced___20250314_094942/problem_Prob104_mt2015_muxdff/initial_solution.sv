module TopModule (
    input logic clk,              // Clock input, active on rising edge
    input logic L,                // Load signal; when high, loads input data
    input logic [2:0] r_in,      // 3-bit input data for loading registers
    input logic q_in,            // Input for multiplexer (1 bit)
    output logic q_out           // Output from the flip-flop (1 bit)
);

always @(posedge clk) begin
    if (L) begin
        // Load behavior
        q_out <= r_in[0]; // Assuming q_out is the least significant bit
    end else begin
        // Multiplexing behavior: select q_in when L is low
        q_out <= q_in;
    end
end

endmodule