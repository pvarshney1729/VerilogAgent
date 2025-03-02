module TopModule (
    input logic clk,
    input logic reset,
    input logic [1:0] a,
    input logic [1:0] b,
    output logic [3:0] out
);

    logic [3:0] mux_out;

    // Combinational logic using multiplexers based on K-map
    always @(*) begin
        case ({a, b})
            4'b00: mux_out = 4'b0001; // Example output for a=0, b=0
            4'b01: mux_out = 4'b0010; // Example output for a=0, b=1
            4'b10: mux_out = 4'b0100; // Example output for a=1, b=0
            4'b11: mux_out = 4'b1000; // Example output for a=1, b=1
            default: mux_out = 4'b0000; // Default case
        endcase
    end

    // Synchronous reset implementation
    always @(posedge clk) begin
        if (reset) begin
            out <= 4'b0000; // Initialize output to zero on reset
        end else begin
            out <= mux_out; // Update output with mux result
        end
    end

endmodule