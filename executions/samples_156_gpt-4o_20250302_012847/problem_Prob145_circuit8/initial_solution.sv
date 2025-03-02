module TopModule (
    input logic clk,
    input logic a,
    output logic p,
    output logic q
);

    logic p_next;

    always @(posedge clk) begin
        if (a) begin
            p <= 1'b1;
        end else begin
            p <= 1'b0;
        end
    end

    always @(posedge clk) begin
        q <= p;
    end

endmodule