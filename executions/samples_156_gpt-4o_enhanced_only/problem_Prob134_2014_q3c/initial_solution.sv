module TopModule(
    input logic clk,
    input logic x,
    input logic [2:0] y,
    output logic Y0,
    output logic z
);
    // Internal signal to hold the next state
    logic [2:0] next_state;

    // Combinational logic to determine the next state and output z
    always @(*) begin
        // Default assignments
        next_state = 3'b000;
        z = 1'b0;

        // State transition and output logic
        case (y)
            3'b000: begin
                next_state = (x == 1'b0) ? 3'b000 : 3'b001;
                z = 1'b0;
            end
            3'b001: begin
                next_state = (x == 1'b0) ? 3'b001 : 3'b100;
                z = 1'b0;
            end
            3'b010: begin
                next_state = (x == 1'b0) ? 3'b010 : 3'b001;
                z = 1'b0;
            end
            3'b011: begin
                next_state = (x == 1'b0) ? 3'b001 : 3'b010;
                z = 1'b1;
            end
            3'b100: begin
                next_state = (x == 1'b0) ? 3'b011 : 3'b100;
                z = 1'b1;
            end
            default: begin
                next_state = 3'b000; // Safe state on undefined input
                z = 1'b0;
            end
        endcase
    end

    // Sequential logic for state update on the rising edge of clk
    always_ff @(posedge clk) begin
        y <= next_state;
    end

    // Assign the LSB of next_state to output Y0
    assign Y0 = next_state[0];

endmodule