module TopModule (
    input wire in,                   // Input signal, 1 bit
    input wire [3:0] state,          // Current state, 4 bits, one-hot encoded
    output reg [3:0] next_state,     // Next state, 4 bits, one-hot encoded
    output reg out                   // Output signal, 1 bit
);

    always @(*) begin
        // Default assignments
        next_state = 4'b0000;
        out = 1'b0;

        // State transition logic
        case (state)
            4'b0001: next_state = (in == 1'b0) ? 4'b0001 : 4'b0010; // State A
            4'b0010: next_state = (in == 1'b0) ? 4'b0100 : 4'b0010; // State B
            4'b0100: next_state = (in == 1'b0) ? 4'b0001 : 4'b1000; // State C
            4'b1000: next_state = (in == 1'b0) ? 4'b0100 : 4'b0010; // State D
            default: next_state = 4'b0000; // Undefined state handling
        endcase

        // Output logic
        if (state == 4'b1000) begin
            out = 1'b1; // State D
        end
    end

endmodule