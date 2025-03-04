module TopModule (
    input logic clk,
    input logic reset,
    input logic a,
    input logic b,
    output logic q,
    output logic state
);

    logic next_state;

    // Combinational logic for q
    always @(*) begin
        if (a && !b) begin
            q = ~state;
        end else if (a && b) begin
            q = 1'b0;
        end else begin
            q = state;
        end
    end

    // Sequential logic for state
    always @(posedge clk) begin
        if (reset) begin
            state <= 1'b0;
        end else if (b) begin
            state <= a;
        end
    end

endmodule