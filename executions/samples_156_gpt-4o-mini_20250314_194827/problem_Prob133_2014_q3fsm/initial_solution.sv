module TopModule (
    input logic clk,
    input logic reset,
    input logic s,
    input logic w,
    output logic z
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        COUNT = 2'b01,
        CHECK = 2'b10
    } state_t;

    state_t current_state, next_state;
    logic [1:0] w_count;

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            w_count <= 2'b00;
        end else begin
            current_state <= next_state;
            if (current_state == COUNT) begin
                w_count <= w_count + (w ? 1 : 0);
            end
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (s) begin
                    next_state = COUNT;
                end else begin
                    next_state = IDLE;
                end
            end
            COUNT: begin
                if (w_count == 2'b11) begin
                    next_state = CHECK;
                end else begin
                    next_state = COUNT;
                end
            end
            CHECK: begin
                next_state = IDLE; // Transition back to IDLE after checking
            end
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    assign z = (current_state == CHECK && w_count == 2'b11) ? 1'b1 : 1'b0;

endmodule