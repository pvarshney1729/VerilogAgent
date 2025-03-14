module TopModule(
    input logic clk,
    input logic a,
    output logic [2:0] q
);

    always_ff @(posedge clk) begin
        if (a) begin
            q <= 3'b100; // hold q at 4 when 'a' is 1
        end else begin
            case (q)
                3'b101: q <= 3'b110; // 5 -> 6
                3'b110: q <= 3'b000; // 6 -> 0
                3'b000: q <= 3'b001; // 0 -> 1
                3'b001: q <= 3'b101; // 1 -> 5
                default: q <= 3'b101; // default to 5 to start sequence
            endcase
        end
    end

endmodule