module TopModule (
    input logic clk,
    input logic a,
    input logic b,
    output logic q,
    output logic state
);

    // Internal signal for state
    logic internal_state;

    // Initialize state and q to 0
    initial begin
        internal_state = 1'b0;
        q = 1'b0;
    end

    // Sequential logic for state update
    always_ff @(posedge clk) begin
        if (a == 1'b1 && b == 1'b0) begin
            internal_state <= 1'b0;
        end else if (a == 1'b0 && b == 1'b1) begin
            internal_state <= 1'b1;
        end
    end

    // Combinational logic for output q
    always_comb begin
        if (internal_state == 1'b1) begin
            q = a & b;
        end else begin
            q = a | b;
        end
    end

    // Assign internal state to output state
    assign state = internal_state;

endmodule