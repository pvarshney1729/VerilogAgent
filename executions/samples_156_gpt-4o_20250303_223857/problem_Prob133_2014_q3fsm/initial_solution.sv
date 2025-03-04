module TopModule (
    input logic clk,    // Clock signal, positive edge-triggered
    input logic reset,  // Reset signal, active high, synchronous
    input logic s,      // Input signal, one bit, used to transition from state A to B
    input logic w,      // Input signal, one bit, examined in state B
    output logic z      // Output signal, one bit, determined by FSM logic
);

    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01
    } state_t;

    state_t current_state, next_state;
    logic [1:0] w_count; // Counter for occurrences of w = 1

    // State transition and output logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= A;
            z <= 1'b0;
            w_count <= 2'b00;
        end else begin
            current_state <= next_state;
            if (current_state == B) begin
                if (w_count == 2'b10) begin
                    z <= 1'b1;
                end else begin
                    z <= 1'b0;
                end
            end else begin
                z <= 1'b0;
            end
        end
    end

    // Next state logic and w count
    always_comb begin
        next_state = current_state;
        case (current_state)
            A: begin
                if (s) begin
                    next_state = B;
                    w_count = 2'b00;
                end
            end
            B: begin
                if (s == 0) begin
                    next_state = A;
                end else begin
                    if (w) begin
                        w_count = w_count + 1;
                    end
                    if (w_count == 2'b10) begin
                        next_state = A;
                    end
                end
            end
        endcase
    end

endmodule