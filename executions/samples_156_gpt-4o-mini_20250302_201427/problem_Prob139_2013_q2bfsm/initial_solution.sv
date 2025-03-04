module TopModule (
    input logic clk,       // Clock input, positive edge-triggered
    input logic resetn,    // Synchronous active-low reset
    input logic x,         // Input signal from the motor
    input logic y,         // Input signal from the motor
    output logic f,        // Output signal to control the motor
    output logic g         // Output signal to control the motor
);

    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [2:0] x_sequence; // To track the sequence of x

    always_ff @(posedge clk) begin
        if (!resetn) begin
            current_state <= A;
            f <= 1'b0;
            g <= 1'b0;
            x_sequence <= 3'b000;
        end else begin
            current_state <= next_state;
            if (current_state == B) begin
                f <= 1'b1;
            end else begin
                f <= 1'b0;
            end
        end
    end

    always_ff @(posedge clk) begin
        if (current_state == C) begin
            x_sequence <= {x_sequence[1:0], x}; // Shift in the new x value
        end
    end

    always_comb begin
        case (current_state)
            A: begin
                next_state = (resetn) ? B : A;
            end
            B: begin
                next_state = C;
            end
            C: begin
                if (x_sequence == 3'b101) begin
                    next_state = D;
                end else begin
                    next_state = C;
                end
            end
            D: begin
                if (g == 1'b0) begin
                    g <= 1'b1; // Set g for one clock cycle
                end
                if (y) begin
                    g <= 1'b1; // Maintain g = 1 if y becomes 1
                end else begin
                    next_state = D; // Stay in D if y is not 1
                end
            end
            default: next_state = A;
        endcase
    end

endmodule