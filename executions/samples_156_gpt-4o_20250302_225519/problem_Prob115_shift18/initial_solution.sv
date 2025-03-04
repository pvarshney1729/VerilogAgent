module TopModule (
    input logic clk,
    input logic load,
    input logic ena,
    input logic [1:0] amount,
    input logic [63:0] data,
    output logic [63:0] q
);

    // Initial state of q
    initial begin
        q = 64'b0;
    end

    always_ff @(posedge clk) begin
        if (load) begin
            q <= data;
        end else if (ena) begin
            case (amount)
                2'b00: q <= q << 1;  // Shift left by 1 bit
                2'b01: q <= q << 8;  // Shift left by 8 bits
                2'b10: q <= $signed(q) >>> 1;  // Arithmetic shift right by 1 bit
                2'b11: q <= $signed(q) >>> 8;  // Arithmetic shift right by 8 bits
                default: q <= q;  // Default case to handle any unexpected values
            endcase
        end
    end

endmodule