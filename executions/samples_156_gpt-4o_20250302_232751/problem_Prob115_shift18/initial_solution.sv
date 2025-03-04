module TopModule (
    input logic clk,         // Clock signal, active on rising edge.
    input logic reset,       // Synchronous reset signal, active high.
    input logic load,        // Load signal, active high.
    input logic ena,         // Enable signal, active high.
    input logic [1:0] amount,// Determines shift direction and amount.
    input logic [63:0] data, // Input data for loading into the shift register.
    output logic [63:0] q    // Output of the shift register.
);

always @(posedge clk) begin
    if (reset) begin
        q <= 64'b0;
    end else if (load) begin
        q <= data;
    end else if (ena) begin
        case (amount)
            2'b00: q <= q << 1;
            2'b01: q <= q << 8;
            2'b10: q <= {q[63], q[63:1]}; // Arithmetic right shift by 1
            2'b11: q <= { {8{q[63]}}, q[63:8] }; // Arithmetic right shift by 8
            default: q <= q; // Default case to handle unexpected values
        endcase
    end
end

endmodule