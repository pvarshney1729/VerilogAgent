module TopModule (
    input logic clk,
    input logic load,
    input logic ena,
    input logic [1:0] amount,
    input logic [63:0] data,
    output logic [63:0] q
);

    always_ff @(posedge clk) begin
        if (load) begin
            q <= data;
        end else if (ena) begin
            case (amount)
                2'b00: q <= {q[62:0], 1'b0}; // Shift left by 1 bit, fill LSB with 0
                2'b01: q <= {q[55:0], 8'b0}; // Shift left by 8 bits, fill lower 8 bits with 0
                2'b10: q <= {q[63], q[63:1]}; // Shift right by 1 bit, retain MSB for sign
                2'b11: q <= {{8{q[63]}}, q[63:8]}; // Shift right by 8 bits, sign extend
                default: q <= q; // Default case to handle unexpected values
            endcase
        end
    end

endmodule