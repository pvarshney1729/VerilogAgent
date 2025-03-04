module TopModule (
    input logic clk,               // Clock signal
    input logic resetn,            // Active-low synchronous reset
    input logic [2:0] r,           // Request signals, r[0] is highest priority
    output logic [2:0] g           // Grant signals, corresponds to r
);

    // State definitions
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            current_state <= A;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            A: begin
                if (r[0])
                    next_state = B;
                else if (r[1])
                    next_state = C;
                else if (r[2])
                    next_state = D;
                else
                    next_state = A;
            end
            B: begin
                if (r[0])
                    next_state = B;
                else
                    next_state = A;
            end
            C: begin
                if (r[1])
                    next_state = C;
                else
                    next_state = A;
            end
            D: begin
                if (r[2])
                    next_state = D;
                else
                    next_state = A;
            end
            default: next_state = A;
        endcase
    end

    // Output logic
    always_comb begin
        g = 3'b000; // Default output
        case (current_state)
            B: g[0] = 1'b1;
            C: g[1] = 1'b1;
            D: g[2] = 1'b1;
            default: g = 3'b000;
        endcase
    end

endmodule