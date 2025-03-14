module TopModule (
    input  wire clk,          // Clock signal (1 bit)
    input  wire a,            // Input signal (1 bit)
    input  wire rst,          // Asynchronous reset signal (1 bit)
    output reg [2:0] q        // Output signal (3 bits, unsigned) 
);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        q <= 3'b000;  // Reset condition
    end else begin
        if (a) begin
            q <= q + 1; // Increment q if a is high
        end // Else retain current state
    end
end

endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly