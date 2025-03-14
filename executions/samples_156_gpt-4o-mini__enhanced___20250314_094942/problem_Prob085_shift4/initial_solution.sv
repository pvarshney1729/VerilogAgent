module TopModule (
    input logic clk,             // Clock input
    input logic areset,         // Asynchronous active high reset
    input logic load,           // Synchronous active high load signal
    input logic ena,            // Synchronous active high enable signal
    input logic [3:0] data,     // Input data (4 bits)
    output logic [3:0] q        // Output of the shift register (4 bits)
);

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            q <= 4'b0000; // Reset q to zero
        end else if (load) begin
            q <= data; // Load data into q
        end else if (ena) begin
            q <= {1'b0, q[3:1]}; // Shift right
        end
    end
endmodule