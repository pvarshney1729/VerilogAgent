[BEGIN]
module TopModule (
    input logic clk,
    input logic L,
    input logic d0,
    input logic d1,
    output logic Q
);

    logic selected_d;

    always @(*) begin
        if (L) begin
            selected_d = d0;
        end else begin
            selected_d = d1;
        end
    end

    always @(posedge clk) begin
        Q <= selected_d;
    end

endmodule
[DONE]