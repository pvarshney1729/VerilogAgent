module TopModule (
    input  logic clk,
    input  logic a,
    output logic [2:0] q
);

    always_ff @(posedge clk) begin
        if (a == 1'b0) begin
            q <= q + 3'b001;
        end
    end

endmodule