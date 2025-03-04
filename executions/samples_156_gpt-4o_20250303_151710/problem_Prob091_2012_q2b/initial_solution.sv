module TopModule (
    input logic [5:0] y,
    input logic w,
    input logic clk,
    input logic rst,
    output logic Y1,
    output logic Y3
);

    // State transition logic
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset to state A
            y <= 6'b000001;
        end else begin
            case (y)
                6'b000001: y <= (w) ? 6'b000010 : 6'b000001; // A to B or stay in A
                6'b000010: y <= (w) ? 6'b000100 : 6'b001000; // B to C or D
                6'b000100: y <= (w) ? 6'b010000 : 6'b001000; // C to E or D
                6'b001000: y <= (w) ? 6'b100000 : 6'b000001; // D to F or A
                6'b010000: y <= (w) ? 6'b010000 : 6'b001000; // E to E or D
                6'b100000: y <= (w) ? 6'b000100 : 6'b001000; // F to C or D
                default: y <= 6'b000001; // Handle illegal states by resetting to A
            endcase
        end
    end

    // Output logic
    assign Y1 = (y == 6'b000001) & w; // Y1 is high when transitioning from A to B
    assign Y3 = ((y == 6'b000010) & ~w) | ((y == 6'b000100) & ~w) | ((y == 6'b010000) & ~w) | ((y == 6'b100000) & ~w); // Y3 is high when transitioning to D

endmodule