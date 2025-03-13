module TopModule (
    input logic clock,
    input logic a,
    output logic p,
    output logic q
);

    logic state;
    logic next_state;

    // Sequential logic to update state
    always @(posedge clock) begin
        if (state == 1'b0 && a == 1'b1) begin
            next_state <= 1'b1;
        end else if (state == 1'b1 && a == 1'b0) begin
            next_state <= 1'b0;
        end
    end

    // Output logic
    always @(*) begin
        p = state;
        q = (state == 1'b1) ? 1'b0 : 1'b1;
    end

    // Initialize state
    initial begin
        state = 1'b0;
        next_state = 1'b0;
    end

endmodule