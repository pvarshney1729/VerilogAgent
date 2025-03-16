module TopModule (
    input  logic clk,
    input  logic a,
    output logic q
);

    logic state;

    always_ff @(posedge clk) begin
        if (a == 1'b1) begin
            state <= 1'b0;
        end else begin
            state <= 1'b1;
        end
    end

    assign q = state;

endmodule