module TopModule (
    input  logic clk,
    input  logic w,
    input  logic R,
    input  logic E,
    input  logic L,
    output logic Q
);

    logic q_reg, q_next;

    // Combinational logic to determine the next state
    always @(*) begin
        if (L) begin
            q_next = R; // Load the value R when L is asserted
        end else if (E) begin
            q_next = w; // Shift the value from the previous stage when E is asserted
        end else begin
            q_next = q_reg; // Hold the current state
        end
    end

    // Sequential logic to update the state on the positive edge of the clock
    always @(posedge clk) begin
        q_reg <= q_next;
    end

    // Output assignment
    assign Q = q_reg;

endmodule