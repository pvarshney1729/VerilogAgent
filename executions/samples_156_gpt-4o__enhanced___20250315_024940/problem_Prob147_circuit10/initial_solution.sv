module TopModule (
    input  logic clk,
    input  logic a,
    input  logic b,
    output logic q,
    output logic state
);

    // Internal signal to hold the state of the flip-flop
    logic flip_flop_state;

    // Combinational logic to determine the next state of the flip-flop
    always @(*) begin
        // Next state logic based on inputs a and b
        if (a && !b) begin
            flip_flop_state = 0; // Set state to 0 when a is 1 and b is 0
        end else if (a && b) begin
            flip_flop_state = 1; // Set state to 1 when both a and b are 1
        end else begin
            flip_flop_state = flip_flop_state; // Retain previous state
        end
    end

    // Sequential logic to update the flip-flop on the positive edge of clk
    always @(posedge clk) begin
        q <= flip_flop_state; // Update q output
        state <= flip_flop_state; // Update state output
    end

    // Initialize the flip-flop state to 0
    initial begin
        flip_flop_state = 0;
    end

endmodule