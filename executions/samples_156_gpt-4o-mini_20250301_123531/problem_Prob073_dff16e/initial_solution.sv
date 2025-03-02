module TopModule (
    input logic clk,         // Clock signal, positive edge triggered
    input logic resetn,      // Active-low synchronous reset
    input logic [1:0] byteena, // Byte enable signals
    input logic [15:0] d,    // 16-bit data input
    output logic [15:0] q     // 16-bit data output
);

always @(posedge clk) begin
    if (!resetn) begin
        q <= 16'b0; // Reset q to 0
    end else begin
        if (byteena[1] && !byteena[0]) begin
            q[15:8] <= d[15:8]; // Update upper byte
        end else if (!byteena[1] && byteena[0]) begin
            q[7:0] <= d[7:0];   // Update lower byte
        end else if (byteena[1] && byteena[0]) begin
            q <= d;             // Update entire q
        end
        // If both byteena are low, retain previous state of q
    end
end

endmodule