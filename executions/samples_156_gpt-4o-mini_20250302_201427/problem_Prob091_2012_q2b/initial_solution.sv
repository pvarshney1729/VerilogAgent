module TopModule (
    input logic [5:0] y,      // One-hot encoded current state
    input logic w,            // Control signal for state transitions
    input logic clk,          // Clock signal for sequential logic
    input logic rst_n,        // Active-low asynchronous reset
    output logic Y1,          // Determines the next state transition for state B
    output logic Y3           // Determines the next state transition for state D
);

    // State transition logic
    always @(posedge clk) begin
        if (!rst_n) begin
            y <= 6'b000001;  // Reset to state A
        end else begin
            case (y)
                6'b000001: y <= (w) ? 6'b000010 : 6'b000001; // A
                6'b000010: y <= (w) ? 6'b000100 : 6'b001000; // B
                6'b000100: y <= (w) ? 6'b010000 : 6'b001000; // C
                6'b001000: y <= (w) ? 6'b100000 : 6'b000001; // D
                6'b010000: y <= (w) ? 6'b010000 : 6'b001000; // E
                6'b100000: y <= (w) ? 6'b000100 : 6'b001000; // F
                default:   y <= 6'b000001; // Illegal state, reset to A
            endcase
        end
    end

    // Output logic
    assign Y1 = y[1]; // Transition to state B
    assign Y3 = y[3]; // Transition to state D

endmodule