module TopModule (
    input logic clk,
    input logic rst_n,
    input logic a,
    output logic [2:0] q
);

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            q <= 3'b000;
        end else if (a) begin
            q <= 3'b100;
        end else begin
            case (q)
                3'b100: q <= 3'b101;
                3'b101: q <= 3'b110;
                3'b110: q <= 3'b000;
                3'b000: q <= 3'b001;
                3'b001: q <= 3'b010;
                3'b010: q <= 3'b011;
                3'b011: q <= 3'b100;
                default: q <= 3'b000;
            endcase
        end
    end

endmodule