module TopModule (
    input logic clk,
    input logic L,
    input logic d0,
    input logic d1,
    output logic Q
);

    always_ff @(posedge clk) begin
        if (L) begin
            Q <= d0;
        end else begin
            Q <= d1;
        end
    end

endmodule