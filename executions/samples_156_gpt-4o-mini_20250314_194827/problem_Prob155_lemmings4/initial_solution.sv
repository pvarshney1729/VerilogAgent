module state_machine (
    input logic clk,
    input logic rst_n,
    input logic start,
    output logic done
);

    typedef enum logic [1:0] {
        S_IDLE = 2'b00,
        S_RUN  = 2'b01,
        S_DONE = 2'b10
    } state_t;

    state_t current_state, next_state;
    logic [3:0] fall_counter;

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (!rst_n) begin
            current_state <= S_IDLE;
            fall_counter <= 4'b0000;
        end else begin
            current_state <= next_state;
            if (current_state == S_RUN) begin
                fall_counter <= fall_counter + 1'b1;
            end
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            S_IDLE: begin
                if (start) 
                    next_state = S_RUN;
                else 
                    next_state = S_IDLE;
            end
            S_RUN: begin
                if (fall_counter == 4'b1111) // Example condition for transition
                    next_state = S_DONE;
                else 
                    next_state = S_RUN;
            end
            S_DONE: begin
                next_state = S_IDLE; // Transition back to idle
            end
            default: next_state = S_IDLE;
        endcase
    end

    // Output logic
    assign done = (current_state == S_DONE);

endmodule