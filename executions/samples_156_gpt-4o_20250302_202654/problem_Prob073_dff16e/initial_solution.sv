module TopModule (
    input logic clk,          // Clock signal
    input logic resetn,       // Active-low synchronous reset
    input logic [1:0] byteena,// Byte enable signals
    input logic [15:0] d,     // 16-bit data input
    output logic [15:0] q     // 16-bit data output
);

    always_ff @(posedge clk) begin
        if (!resetn) begin
            q <= 16'b0; // Reset all outputs to zero
        end else begin
            if (byteena[1]) begin
                q[15:8] <= d[15:8]; // Update upper byte
            end
            if (byteena[0]) begin
                q[7:0] <= d[7:0];   // Update lower byte
            end
        end
    end

endmodule