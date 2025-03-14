module TopModule (
    input logic clk,                // Clock input (1 bit)
    input logic resetn,            // Synchronous active-low reset (1 bit)
    input logic [1:0] byteena,     // Byte enable signals (2 bits)
    input logic [15:0] d,           // Data input (16 bits)
    output logic [15:0] q            // Output data (16 bits)
);

always @(posedge clk) begin
    if (!resetn) begin
        q <= 16'b0; // Reset state for all DFFs
    end else begin
        if (byteena[0]) 
            q[7:0] <= d[7:0]; // Write lower byte
        if (byteena[1]) 
            q[15:8] <= d[15:8]; // Write upper byte
    end
end

endmodule