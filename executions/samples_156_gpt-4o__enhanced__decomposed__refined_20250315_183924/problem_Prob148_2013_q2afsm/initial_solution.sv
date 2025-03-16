[BEGIN]
module TopModule(
    input logic clk,          // Clock input
    input logic resetn,       // Active-low synchronous reset
    input logic [2:0] r,      // 3-bit request input vector, r[0] is highest priority
    output logic [2:0] g      // 3-bit grant output vector, g[0] corresponds to r[0]
);

    // State encoding
    localparam A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;
    logic [1:0] current_state, next_state;

    // State transition logic
    always @(posedge clk) begin
        if (!resetn) begin
            current_state <= A; // Reset to state A
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            A: begin
                if (r[0]) next_state = B;
                else if (r[1]) next_state = C;
                else if (r[2]) next_state = D;
                else next_state = A;
            end
            B: begin
                if (r[0]) next_state = B;
                else next_state = A;
            end
            C: begin
                if (r[1]) next_state = C;
                else next_state = A;
            end
            D: begin
                if (r[2]) next_state = D;
                else next_state = A;
            end
            default: next_state = A; // Default case to handle invalid states
        endcase
    end

    // Output logic for grant signals
    always @(*) begin
        g = 3'b000; // Default output
        case (current_state)
            B: g = 3'b001;
            C: g = 3'b010;
            D: g = 3'b100;
        endcase
    end

endmodule
[DONE]