[BEGIN]
module TopModule (
    input logic clk,             // Clock input, triggers all sequential logic on the positive edge
    input logic reset,           // Synchronous reset input, active high
    input logic w,               // Input signal that determines state transitions
    output logic z               // Output signal, depends on the current state
);
    // State encoding using one-hot encoding
    localparam A = 6'b000001;
    localparam B = 6'b000010;
    localparam C = 6'b000100;
    localparam D = 6'b001000;
    localparam E = 6'b010000;
    localparam F = 6'b100000;

    logic [5:0] state, next_state;

    // Synchronous reset and state transitions
    always @(posedge clk) begin
        if (reset) begin
            state <= A; // Initialize to state A on reset
        end else begin
            state <= next_state;
        end
    end

    // Next state logic and output logic
    always @(*) begin
        // Default assignments
        next_state = state;
        z = 1'b0;

        case (state)
            A: begin
                if (w == 1'b0) next_state = B;
                else next_state = A;
            end
            B: begin
                if (w == 1'b0) next_state = C;
                else next_state = D;
            end
            C: begin
                if (w == 1'b0) next_state = E;
                else next_state = D;
            end
            D: begin
                if (w == 1'b0) next_state = F;
                else next_state = A;
            end
            E: begin
                z = 1'b1;
                if (w == 1'b0) next_state = E;
                else next_state = D;
            end
            F: begin
                z = 1'b1;
                if (w == 1'b0) next_state = C;
                else next_state = D;
            end
            default: next_state = A;
        endcase
    end
endmodule
[DONE]