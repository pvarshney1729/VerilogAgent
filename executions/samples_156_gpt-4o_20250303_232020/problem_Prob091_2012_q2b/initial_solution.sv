module TopModule (
    input logic clk,          // Clock signal for synchronization
    input logic reset_n,      // Active low reset signal
    input logic [5:0] y,      // 6-bit input state vector (one-hot encoded)
    input logic w,            // 1-bit input signal
    output logic Y1,          // 1-bit output signal
    output logic Y3           // 1-bit output signal
);

    logic [5:0] state, next_state;

    // State transition logic
    always @(*) begin
        case (y)
            6'b000001: next_state = (w) ? 6'b000010 : 6'b000001; // A
            6'b000010: next_state = (w) ? 6'b000100 : 6'b001000; // B
            6'b000100: next_state = (w) ? 6'b010000 : 6'b001000; // C
            6'b001000: next_state = (w) ? 6'b100000 : 6'b000001; // D
            6'b010000: next_state = (w) ? 6'b010000 : 6'b001000; // E
            6'b100000: next_state = (w) ? 6'b000100 : 6'b001000; // F
            default:   next_state = 6'b000001;                   // Invalid state
        endcase
    end

    // State register with asynchronous reset
    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            state <= 6'b000001; // Reset to state A
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        Y1 = next_state[1];
        Y3 = next_state[3];
    end

endmodule