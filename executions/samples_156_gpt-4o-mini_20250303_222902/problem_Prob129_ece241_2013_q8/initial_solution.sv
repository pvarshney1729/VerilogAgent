module TopModule (
    input logic clk,       // Clock signal, positive edge-triggered
    input logic aresetn,   // Asynchronous active-low reset
    input logic x,         // Input signal to detect the sequence "101"
    output logic z          // Output signal, asserted when sequence "101" is detected
);

    typedef enum logic [1:0] {
        STATE_0 = 2'b00,
        STATE_1 = 2'b01,
        STATE_2 = 2'b10
    } state_t;

    state_t current_state, next_state;

    // Asynchronous reset
    always_ff @(negedge aresetn or posedge clk) begin
        if (!aresetn) begin
            current_state <= STATE_0;
            z <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_ff @(posedge clk) begin
        case (current_state)
            STATE_0: begin
                if (x) begin
                    next_state <= STATE_1;
                end else begin
                    next_state <= STATE_0;
                end
            end
            STATE_1: begin
                if (!x) begin
                    next_state <= STATE_2;
                end else begin
                    next_state <= STATE_1;
                end
            end
            STATE_2: begin
                if (x) begin
                    next_state <= STATE_0;
                    z <= 1'b1; // Assert z when transitioning from STATE_2 to STATE_0
                end else begin
                    next_state <= STATE_1;
                end
            end
            default: begin
                next_state <= STATE_0;
            end
        endcase
    end

    // Output logic
    always_ff @(posedge clk) begin
        if (current_state == STATE_2 && x) begin
            z <= 1'b1; // Assert z when transitioning from STATE_2 to STATE_0
        end else begin
            z <= 1'b0; // Deassert z otherwise
        end
    end

endmodule