module TopModule (
    input logic clk,
    input logic reset,
    input logic [7:0] d,
    output logic [7:0] q
);

    logic [7:0] q_next;

    always @(*) begin
        if (reset) begin
            q_next = 8'h34;
        end else begin
            q_next = d;
        end
    end

    always @(negedge clk) begin
        q <= q_next;
    end

endmodule