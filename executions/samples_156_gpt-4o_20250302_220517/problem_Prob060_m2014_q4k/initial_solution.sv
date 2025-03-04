module TopModule (
    input logic clk,         // Clock signal, positive edge-triggered
    input logic resetn,      // Active-low synchronous reset
    input logic in,          // Input signal to be shifted into the register
    output logic out         // Output signal representing the most significant bit of the shift register
);

    // 4-bit shift register
    logic [3:0] shift_register;

    // Sequential logic for shift register with synchronous reset
    always_ff @(posedge clk) begin
        if (!resetn) begin
            shift_register <= 4'b0000; // Reset to all zeros
        end else begin
            shift_register <= {shift_register[2:0], in}; // Shift right and input new bit
        end
    end

    // Assign the most significant bit to the output
    assign out = shift_register[3];

endmodule