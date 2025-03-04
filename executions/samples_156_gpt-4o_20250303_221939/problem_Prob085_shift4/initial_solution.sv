module TopModule (
    input logic clk,        // Clock signal, positive edge-triggered
    input logic areset,     // Asynchronous reset signal, active high
    input logic load,       // Synchronous load signal, active high
    input logic ena,        // Synchronous enable signal, active high
    input logic [3:0] data, // 4-bit data input for loading into the shift register
    output logic [3:0] q    // 4-bit output representing the current state of the shift register
);

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            q <= 4'b0000; // Asynchronous reset to zero
        end else if (load) begin
            q <= data; // Load data into the shift register
        end else if (ena) begin
            q <= {1'b0, q[3:1]}; // Shift right with MSB set to 0
        end
    end

endmodule