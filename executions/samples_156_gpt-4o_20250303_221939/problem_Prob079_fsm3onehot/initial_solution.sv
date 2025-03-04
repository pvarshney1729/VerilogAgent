module TopModule (
    input logic clk,
    input logic reset_n,
    input logic in,
    input logic [3:0] state,
    output logic [3:0] next_state,
    output logic out
);
    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            next_state <= 4'b0001; // Initialize to state A
        end else begin
            case (state)
                4'b0001: next_state <= (in) ? 4'b0010 : 4'b0001; // A -> B or A -> A
                4'b0010: next_state <= (in) ? 4'b0010 : 4'b0100; // B -> B or B -> C
                4'b0100: next_state <= (in) ? 4'b1000 : 4'b0001; // C -> D or C -> A
                4'b1000: next_state <= (in) ? 4'b0010 : 4'b0100; // D -> B or D -> C
                default: next_state <= 4'b0001; // Default to state A on invalid state
            endcase
        end
    end

    always_comb begin
        case (state)
            4'b0001, 4'b0010, 4'b0100: out = 0; // Output logic for states A, B, C
            4'b1000: out = 1; // Output logic for state D
            default: out = 0; // Default output
        endcase
    end
endmodule