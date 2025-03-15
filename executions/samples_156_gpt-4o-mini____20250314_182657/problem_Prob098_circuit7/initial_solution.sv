module TopModule (
    input logic clk,
    input logic a,
    output logic q
);

    logic state;

    always @(posedge clk) begin
        if (state == 1'b0 && a == 1'b1) begin
            state <= 1'b1;
        end else if (state == 1'b1 && a == 1'b0) begin
            state <= 1'b0;
        end
    end

    assign q = state;

endmodule