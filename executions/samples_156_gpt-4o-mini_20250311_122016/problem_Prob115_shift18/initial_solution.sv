[BEGIN]
module TopModule (
    input        clk,      // Clock input, assumed to be rising edge triggered
    input        load,     // Synchronous load signal, active high
    input        ena,      // Enable signal for shifting, active high
    input  logic [1:0] amount,   // Shift direction and amount control
    input  logic [63:0] data,    // Data input for loading
    output logic [63:0] q        // Shift register output
);

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end else if (ena) begin
        case (amount)
            2'b00: q <= {q[62:0], 1'b0};                // Shift left by 1
            2'b01: q <= {q[55:0], 8'b0};                // Shift left by 8
            2'b10: q <= {q[63], q[63:1]};               // Arithmetic shift right by 1
            2'b11: q <= {{8{q[63]}}, q[63:8]};          // Arithmetic shift right by 8
            default: q <= q;                           // Default case, no shift
        endcase
    end
end

endmodule
[DONE]