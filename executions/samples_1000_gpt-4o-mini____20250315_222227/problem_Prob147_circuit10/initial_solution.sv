module TopModule (
    input logic clk,
    input logic a,
    input logic b,
    output logic q,
    output logic state
);

    logic ff_state;

    // Combinational logic
    always @(*) begin
        if (ff_state == 1'b0) begin
            q = 1'b0;
        end else if (a == 1'b1 && b == 1'b0) begin
            q = 1'b0;
        end else if (a == 1'b1 && b == 1'b1) begin
            q = 1'b1;
        end else begin
            q = ff_state;
        end
    end

    // Sequential logic
    always @(posedge clk) begin
        ff_state <= q;
    end

    assign state = ff_state;

endmodule