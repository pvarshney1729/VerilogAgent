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
        if (L) begin
            Q_next = R;
        end else if (E) begin
            Q_next = w;
        end else begin
            Q_next = Q;
        end
    end

    always @(posedge clk) begin
        Q <= Q_next;
    end

endmodule