module TopModule (
    input logic clk,
    input logic a,
    output logic q
);

    logic state;

    always @(posedge clk) begin
        if (state == 0) begin
            if (a == 1) begin
                state <= 1;
            end
        end else begin
            if (a == 0) begin
                state <= 0;
            end
        end
    end

    assign q = state;

endmodule