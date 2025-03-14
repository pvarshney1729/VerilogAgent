module TopModule (
    input logic clk,         // Clock signal
    input logic load,        // Active high load signal
    input logic ena,         // Active high enable for shifting
    input logic [1:0] amount, // 2-bit control for shift direction and amount
    input logic [63:0] data,  // 64-bit input data
    output logic [63:0] q     // 64-bit output register
);

    always_ff @(posedge clk) begin
        if (load) begin
            q <= data;
        end else if (ena) begin
            case (amount)
                2'b00: q <= q << 1;  // Shift left by 1 bit
                2'b01: q <= q << 8;  // Shift left by 8 bits
                2'b10: q <= $signed(q) >>> 1; // Arithmetic shift right by 1 bit
                2'b11: q <= $signed(q) >>> 8; // Arithmetic shift right by 8 bits
                default: q <= q; // Default case to retain value
            endcase
        end
    end

endmodule