module TopModule (
    input clk,
    input L,
    input q_in,
    input r_in,
    output Q
);
    logic Q_int;

    always @(posedge clk) begin
        if (L) begin
            Q_int <= r_in;
        end else begin
            Q_int <= q_in ^ r_in;
        end
    end

    assign Q = Q_int;

endmodule