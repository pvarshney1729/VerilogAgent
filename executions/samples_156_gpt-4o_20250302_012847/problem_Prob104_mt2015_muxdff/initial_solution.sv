module flip_flop (
    input logic clk,
    input logic L,
    input logic D,
    output logic Q
);

    always_ff @(posedge clk) begin
        if (L)
            Q <= D;
    end

endmodule