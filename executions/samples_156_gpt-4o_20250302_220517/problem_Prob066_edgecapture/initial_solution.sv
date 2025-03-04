module TopModule (
    input logic clk,                  // 1-bit clock signal
    input logic reset,                // 1-bit synchronous active-high reset
    input logic [31:0] in,            // 32-bit input vector
    output logic [31:0] out           // 32-bit output vector
);

    logic [31:0] previous_in;         // Register to hold the previous state of the input

    // Sequential logic to implement the described behavior
    always @(posedge clk) begin
        if (reset) begin
            out <= 32'b0; // Reset all output bits to 0 on reset
            previous_in <= 32'b0; // Reset previous_in on reset
        end else begin
            for (int i = 0; i < 32; i = i + 1) begin
                if (previous_in[i] && !in[i]) begin
                    out[i] <= 1'b1; // Capture transition from 1 to 0
                end
            end
            previous_in <= in; // Update previous_in with current in
        end
    end

endmodule