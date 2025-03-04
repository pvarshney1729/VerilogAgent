module TopModule (
    input  wire clk,        // Clock signal, positive edge triggered
    input  wire aresetn,    // Active-low asynchronous reset
    input  wire x,          // 1-bit input signal
    output reg  z           // 1-bit output signal
);

    // State encoding
    typedef enum logic [1:0] {
        S0 = 2'b00,
        S1 = 2'b01,
        S2 = 2'b10
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(posedge clk or negedge aresetn) begin
        if (!aresetn) begin
            state <= S0;
            z <= 1'b0;
        end else begin
            state <= next_state;
            if (state == S2 && x) begin
                z <= 1'b1;
            end else begin
                z <= 1'b0;
            end
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            S0: begin
                if (x) next_state = S1;
                else next_state = S0;
            end
            S1: begin
                if (!x) next_state = S2;
                else next_state = S1;
            end
            S2: begin
                if (x) next_state = S1;
                else next_state = S0;
            end
            default: next_state = S0;
        endcase
    end

endmodule