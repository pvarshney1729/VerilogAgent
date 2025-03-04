module TopModule (
    input logic [5:0] y,  // 6-bit bus, unsigned, one-hot encoded state
    input logic w,        // 1-bit input, unsigned
    input logic clk,      // Clock signal
    input logic reset_n,  // Asynchronous reset, active low
    output logic Y1,      // 1-bit output, unsigned
    output logic Y3       // 1-bit output, unsigned
);

    // State transition logic
    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            y <= 6'b000001; // Initial state A
        end else begin
            case (y)
                6'b000001: y <= (w) ? 6'b000010 : 6'b000001; // A -> B or A
                6'b000010: y <= (w) ? 6'b000100 : 6'b001000; // B -> C or D
                6'b000100: y <= (w) ? 6'b010000 : 6'b001000; // C -> E or D
                6'b001000: y <= (w) ? 6'b100000 : 6'b000001; // D -> F or A
                6'b010000: y <= (w) ? 6'b010000 : 6'b001000; // E -> E or D
                6'b100000: y <= (w) ? 6'b000100 : 6'b001000; // F -> C or D
                default:   y <= 6'b000001; // Default to state A on invalid state
            endcase
        end
    end

    // Output logic
    always_comb begin
        Y1 = (y == 6'b000010); // Y1 is high when in state B
        Y3 = (y == 6'b001000); // Y3 is high when in state D
    end

endmodule