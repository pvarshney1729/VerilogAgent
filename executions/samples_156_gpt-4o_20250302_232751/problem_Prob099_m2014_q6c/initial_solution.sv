module TopModule (
    input logic [5:0] y,
    input logic w,
    input logic clk,
    input logic rst_n,
    output logic Y1,
    output logic Y2,
    output logic Y3,
    output logic Y4
);

    logic [5:0] next_state;
    logic [5:0] current_state;

    // State Transition Logic
    always @(*) begin
        case (current_state)
            6'b000001: next_state = (w == 0) ? 6'b000010 : 6'b000001; // State A
            6'b000010: next_state = (w == 0) ? 6'b000100 : 6'b001000; // State B
            6'b000100: next_state = (w == 0) ? 6'b010000 : 6'b001000; // State C
            6'b001000: next_state = (w == 0) ? 6'b100000 : 6'b000001; // State D
            6'b010000: next_state = (w == 0) ? 6'b010000 : 6'b001000; // State E
            6'b100000: next_state = (w == 0) ? 6'b000100 : 6'b001000; // State F
            default:   next_state = 6'b000001; // Default to State A
        endcase
    end

    // State Register with Asynchronous Reset
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            current_state <= 6'b000001; // Reset to State A
        else
            current_state <= next_state;
    end

    // Output Logic
    assign Y2 = next_state[1];
    assign Y4 = next_state[3];

    // Y1 and Y3 are undefined in the spec, so they are left unimplemented
    assign Y1 = 1'b0; // Placeholder
    assign Y3 = 1'b0; // Placeholder

endmodule