module TopModule(
    input wire in,              // Unsigned 1-bit input signal
    input wire [1:0] state,     // Unsigned 2-bit state input
    output reg [1:0] next_state,// Unsigned 2-bit next state output
    output reg out              // Unsigned 1-bit output signal
);

    always @(*) begin
        case (state)
            2'b00: begin // State A
                next_state = (in == 1'b0) ? 2'b00 : 2'b01;
                out = 1'b0;
            end
            2'b01: begin // State B
                next_state = (in == 1'b0) ? 2'b10 : 2'b01;
                out = 1'b0;
            end
            2'b10: begin // State C
                next_state = (in == 1'b0) ? 2'b00 : 2'b11;
                out = 1'b0;
            end
            2'b11: begin // State D
                next_state = (in == 1'b0) ? 2'b10 : 2'b01;
                out = 1'b1;
            end
            default: begin // Default case for invalid states
                next_state = 2'b00; // Default to State A
                out = 1'b0;
            end
        endcase
    end

endmodule