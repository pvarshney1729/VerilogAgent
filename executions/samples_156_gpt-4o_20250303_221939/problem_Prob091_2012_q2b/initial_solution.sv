module TopModule (
    input  logic [5:0] y,  // 6-bit one-hot encoded state vector, unsigned
    input  logic       w,  // Control signal for state transition
    input  logic       clk, // Clock signal for synchronous operations
    input  logic       rst_n, // Active-low synchronous reset
    output logic       Y1, // Output logic derived from state
    output logic       Y3  // Output logic derived from state
);

    logic [5:0] next_state;

    // State Transition Logic
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            next_state <= 6'b000001; // Reset to state A
        end else begin
            case (y)
                6'b000001: next_state <= (w) ? 6'b000010 : 6'b000001; // A -> B or A
                6'b000010: next_state <= (w) ? 6'b000100 : 6'b001000; // B -> C or D
                6'b000100: next_state <= (w) ? 6'b010000 : 6'b001000; // C -> E or D
                6'b001000: next_state <= (w) ? 6'b100000 : 6'b000001; // D -> F or A
                6'b010000: next_state <= (w) ? 6'b010000 : 6'b001000; // E -> E or D
                6'b100000: next_state <= (w) ? 6'b000100 : 6'b001000; // F -> C or D
                default:   next_state <= 6'b000001; // Default to state A
            endcase
        end
    end

    // Output Logic
    always_comb begin
        Y1 = next_state[1]; // Output logic for Y1 (state B)
        Y3 = next_state[3]; // Output logic for Y3 (state D)
    end

endmodule