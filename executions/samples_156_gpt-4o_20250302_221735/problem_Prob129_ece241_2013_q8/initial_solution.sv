module TopModule (
    input logic clk,         // Clock signal, positive edge triggered
    input logic aresetn,     // Asynchronous active-low reset
    input logic x,           // Input signal for sequence detection
    output logic z           // Output signal, asserted high when "101" sequence is detected
);

    typedef enum logic [1:0] {
        S0 = 2'b00,
        S1 = 2'b01,
        S2 = 2'b10
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk or negedge aresetn) begin
        if (!aresetn)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    // Next state logic
    always_comb begin
        case (current_state)
            S0: begin
                if (x)
                    next_state = S1;
                else
                    next_state = S0;
            end
            S1: begin
                if (x)
                    next_state = S1;
                else
                    next_state = S2;
            end
            S2: begin
                if (x)
                    next_state = S0;
                else
                    next_state = S1;
            end
            default: next_state = S0;
        endcase
    end

    // Output logic
    always_comb begin
        z = 1'b0;
        if (current_state == S2 && x)
            z = 1'b1;
    end

endmodule