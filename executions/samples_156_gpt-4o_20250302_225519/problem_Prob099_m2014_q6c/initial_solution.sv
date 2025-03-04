module TopModule (
    input logic [5:0] y,    // 6-bit input vector, one-hot encoded state
    input logic w,          // 1-bit input 
    output logic Y1,        // 1-bit output
    output logic Y3,        // 1-bit output
    input logic clk,        // Clock signal for synchronous operations
    input logic reset       // Reset signal, assumed active high
);

    logic [5:0] state;       // Current state

    // State transition logic
    always @(posedge clk) begin
        if (reset) begin
            state <= 6'b000001; // State A
        end else begin
            case (state)
                6'b000001: state <= (w == 1'b0) ? 6'b000010 : 6'b000001; // A -> B or A -> A
                6'b000010: state <= (w == 1'b0) ? 6'b000100 : 6'b001000; // B -> C or B -> D
                6'b000100: state <= (w == 1'b0) ? 6'b010000 : 6'b001000; // C -> E or C -> D
                6'b001000: state <= (w == 1'b0) ? 6'b100000 : 6'b000001; // D -> F or D -> A
                6'b010000: state <= (w == 1'b0) ? 6'b010000 : 6'b001000; // E -> E or E -> D
                6'b100000: state <= (w == 1'b0) ? 6'b000100 : 6'b001000; // F -> C or F -> D
                default: state <= 6'b000001; // Default to State A
            endcase
        end
    end

    // Output logic
    always @(*) begin
        case (state)
            6'b000001: begin
                Y1 = 1'b0;
                Y3 = 1'b0;
            end
            6'b000010: begin
                Y1 = 1'b1;
                Y3 = 1'b0;
            end
            6'b000100: begin
                Y1 = 1'b0;
                Y3 = 1'b1;
            end
            6'b001000: begin
                Y1 = 1'b1;
                Y3 = 1'b1;
            end
            6'b010000: begin
                Y1 = 1'b0;
                Y3 = 1'b0;
            end
            6'b100000: begin
                Y1 = 1'b1;
                Y3 = 1'b0;
            end
            default: begin
                Y1 = 1'b0;
                Y3 = 1'b0;
            end
        endcase
    end

endmodule