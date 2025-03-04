module TopModule (
    input wire clk,
    input wire reset,
    input wire load,
    input wire ena,
    input wire [1:0] amount,
    input wire [63:0] data,
    output reg [63:0] q
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
                2'b10: q <= {q[63], q[63:1]};
                2'b11: q <= {{8{q[63]}}, q[63:8]};
                default: q <= q; // Unspecified behavior, retain current value
            endcase
        end
    end

endmodule