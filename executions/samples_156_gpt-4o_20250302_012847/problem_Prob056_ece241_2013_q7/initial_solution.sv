module jk_flip_flop (
    input logic clk,
    input logic reset,
    input logic j,
    input logic k,
    output logic q
);

    always_ff @(posedge clk) begin
        if (reset) begin
            q <= 1'b0;
        end else begin
            case ({j, k})
                2'b00: q <= q;       // No change
                2'b01: q <= 1'b0;    // Reset
                2'b10: q <= 1'b1;    // Set
                2'b11: q <= ~q;      // Toggle
                default: q <= q;     // Default case
            endcase
        end
    end

endmodule