module TopModule (
    input logic clk,          // Clock signal
    input logic areset,       // Asynchronous reset, active high
    input logic load,         // Synchronous load control, active high
    input logic ena,          // Synchronous enable for right shift, active high
    input logic [3:0] data,   // 4-bit unsigned data input
    output logic [3:0] q      // 4-bit unsigned output
);

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            q <= 4'b0000; // Asynchronous reset
        end else if (load) begin
            q <= data;    // Load data into q
        end else if (ena) begin
            q <= {1'b0, q[3:1]}; // Right shift with zero fill
        end
    end

endmodule