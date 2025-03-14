[BEGIN]
module TopModule (
    input  logic clk,
    input  logic w,
    input  logic R,
    input  logic E,
    input  logic L,
    output logic Q
);

    logic Q_next;

    always @(*) begin
        if (L)
            Q_next = R;
        else if (E)
            Q_next = w;
        else
            Q_next = Q;
    end

    always @(posedge clk) begin
        Q <= Q_next;
    end

endmodule
[DONE]