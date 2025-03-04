module TopModule(
    input logic clk,
    input logic reset,
    input logic load,
    input logic ena,
    input logic [1:0] amount,
    input logic [63:0] data,
    output logic [63:0] q
);

    always_ff @(posedge clk) begin
        if (reset) begin
            q <= 64'b0;
        end else if (load) begin
            q <= data;
        end else if (ena) begin
            case (amount)
                2'b00: q <= q << 1;
                2'b01: q <= q << 8;
                2'b10: q <= $signed(q) >>> 1;
                2'b11: q <= $signed(q) >>> 8;
                default: q <= q; // No operation for undefined amount
            endcase
        end
    end

endmodule