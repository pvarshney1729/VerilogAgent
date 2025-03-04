module TopModule (
    input logic clk,          // Clock signal for sequential logic
    input logic rst_n,        // Active low reset signal, asynchronous
    input logic in,           // Input signal, 1 bit
    input logic [3:0] state,  // Current state, 4 bits, one-hot encoding
    output logic [3:0] next_state, // Next state, 4 bits, one-hot encoding
    output logic out           // Output signal, 1 bit
);

always @(*) begin
    // Default next state and output
    next_state = 4'b0000;
    out = 1'b0;

    case (state)
        4'b0001: begin // State A
            if (in) begin
                next_state = 4'b0010; // A -> B
            end else begin
                next_state = 4'b0001; // A -> A
            end
        end
        4'b0010: begin // State B
            if (in) begin
                next_state = 4'b0010; // B -> B
            end else begin
                next_state = 4'b0100; // B -> C
            end
        end
        4'b0100: begin // State C
            if (in) begin
                next_state = 4'b1000; // C -> D
            end else begin
                next_state = 4'b0001; // C -> A
            end
        end
        4'b1000: begin // State D
            if (in) begin
                next_state = 4'b0010; // D -> B
            end else begin
                next_state = 4'b0100; // D -> C
            end
        end
        default: begin
            // Undefined state handling
            next_state = 4'b0000; // Default to an invalid state
        end
    endcase

    // Output logic
    if (state == 4'b1000) begin
        out = 1'b1; // D produces out=1
    end else begin
        out = 1'b0; // A, B, C produce out=0
    end
end

endmodule