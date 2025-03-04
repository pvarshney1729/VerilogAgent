module TopModule (
    input logic clk,
    input logic rst_n,
    input logic load,
    input logic ena,
    input logic [1:0] amount,
    input logic signed [63:0] data,
    output logic signed [63:0] q
);

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            q <= 64'sd0;
        end else if (load) begin
            q <= data;
        end else if (ena) begin
            case (amount)
                2'b00: q <= q << 1;
                2'b01: q <= q << 8;
                2'b10: q <= q >>> 1;
                2'b11: q <= q >>> 8;
                default: q <= q; // Should not occur
            endcase
        end
    end

endmodule