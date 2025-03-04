module TopModule (
    input logic [5:0] y,
    input logic w,
    input logic clk,
    input logic rst_n,
    output logic Y1,
    output logic Y3
);

    logic [5:0] next_state;
    logic [5:0] current_state;

    // Combinational logic for next state
    always @(*) begin
        next_state = 6'b000001; // Default to state A
        case (current_state)
            6'b000001: next_state = w ? 6'b000010 : 6'b000001; // A -> B or A
            6'b000010: next_state = w ? 6'b000100 : 6'b001000; // B -> C or D
            6'b000100: next_state = w ? 6'b010000 : 6'b001000; // C -> E or D
            6'b001000: next_state = w ? 6'b100000 : 6'b000001; // D -> F or A
            6'b010000: next_state = w ? 6'b010000 : 6'b001000; // E -> E or D
            6'b100000: next_state = w ? 6'b000100 : 6'b001000; // F -> C or D
            default:   next_state = 6'b000001; // Undefined states go to A
        endcase
    end

    // Sequential logic for state transition
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            current_state <= 6'b000001; // Reset to state A
        else
            current_state <= next_state;
    end

    // Output logic
    assign Y1 = next_state[1];
    assign Y3 = next_state[3];

endmodule