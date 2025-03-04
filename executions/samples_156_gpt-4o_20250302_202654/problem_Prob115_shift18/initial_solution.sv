module TopModule (
    input logic clk,
    input logic load,
    input logic ena,
    input logic [1:0] amount,
    input logic signed [63:0] data,
    output logic signed [63:0] q
);

    // Initial state of q
    initial begin
        q = 64'b0;
    end

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else if (ena) begin
            case (amount)
                2'b00: q <= q <<< 1;
                2'b01: q <= q <<< 8;
                2'b10: q <= q >>> 1;
                2'b11: q <= q >>> 8;
                default: q <= q; // No operation for undefined amount
            endcase
        end
    end

endmodule