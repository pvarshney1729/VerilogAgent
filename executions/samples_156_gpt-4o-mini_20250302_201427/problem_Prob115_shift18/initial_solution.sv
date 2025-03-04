module TopModule (
    input logic clk,
    input logic load,
    input logic ena,
    input logic [1:0] amount,
    input logic [63:0] data,
    input logic rst_n,
    output logic [63:0] q
);

    always @(posedge clk) begin
        if (!rst_n) begin
            q <= 64'b0;
        end else if (load) begin
            q <= data;
        end else if (ena) begin
            case (amount)
                2'b00: q <= q << 1;
                2'b01: q <= q << 8;
                2'b10: q <= {q[63], q[63:1]};
                2'b11: q <= {{8{q[63]}}, q[63:8]};
            endcase
        end
    end

endmodule