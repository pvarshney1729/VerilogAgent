module d_latch (
    input logic D,
    input logic enable,
    output logic Q
);

    always @(*) begin
        if (enable) begin
            Q = D;
        end
    end

endmodule