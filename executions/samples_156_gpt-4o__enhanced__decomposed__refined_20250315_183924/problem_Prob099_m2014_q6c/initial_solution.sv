module TopModule (
    input logic [5:0] y,
    input logic w,
    input logic clk,
    input logic reset,
    output logic Y1,
    output logic Y3,
    output logic Y2,
    output logic Y4
);

    logic [5:0] state;
    logic [5:0] next_state;

    // Synchronous reset and state update logic
    always @(posedge clk) begin
        if (reset) begin
            state <= 6'b000001; // Initialize to State A
        end else begin
            state <= next_state;
        end
    end

    // Next-state logic
    always @(*) begin
        case (state)
            6'b000001: next_state = (w) ? 6'b000001 : 6'b000010; // A
            6'b000010: next_state = (w) ? 6'b001000 : 6'b000100; // B
            6'b000100: next_state = (w) ? 6'b001000 : 6'b010000; // C
            6'b001000: next_state = (w) ? 6'b000001 : 6'b100000; // D
            6'b010000: next_state = (w) ? 6'b001000 : 6'b010000; // E
            6'b100000: next_state = (w) ? 6'b001000 : 6'b000100; // F
            default: next_state = 6'b000001; // Default to State A
        endcase
    end

    // Output logic for Y2 and Y4
    assign Y2 = next_state[1];
    assign Y4 = next_state[3];

    // Placeholder logic for Y1 and Y3 (to be defined based on specific conditions)
    assign Y1 = 1'b0; // Example placeholder
    assign Y3 = 1'b0; // Example placeholder

endmodule