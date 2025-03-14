module TopModule (
    input  logic clk,                // Clock signal (1 bit)
    input  logic load,               // Load signal (1 bit, active high)
    input  logic ena,                // Enable signal for shifting (1 bit, active high)
    input  logic [1:0] amount,       // Amount of shift (2 bits)
    input  logic [63:0] data,        // Input data for loading (64 bits, signed)
    output logic [63:0] q             // Output of the shift register (64 bits, signed)
);

    always @(posedge clk) begin
        if (load) begin
            q <= data; // Load data into q
        end else if (ena) begin
            case (amount)
                2'b00: q <= q << 1;               // Shift left by 1 bit
                2'b01: q <= q << 8;               // Shift left by 8 bits
                2'b10: q <= $signed(q) >>> 1;     // Arithmetic right shift by 1 bit
                2'b11: q <= $signed(q) >>> 8;     // Arithmetic right shift by 8 bits
                default: ; // Undefined behavior
            endcase
        end
    end

    initial begin
        q = 64'b0; // Initialize q to zero
    end

endmodule