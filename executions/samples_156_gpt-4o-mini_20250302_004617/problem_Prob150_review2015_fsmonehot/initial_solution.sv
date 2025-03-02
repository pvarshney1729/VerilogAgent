module state_machine (
    input logic clk,
    input logic rst_n,
    input logic start,
    output logic done
);

    typedef enum logic [1:0] {
        S_IDLE = 2'b00,
        S_PROCESS = 2'b01,
        S_DONE = 2'b10
    } state_t;

    state_t current_state, next_state;

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (!rst_n) begin
            current_state <= S_IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            S_IDLE: begin
                if (start) begin
                    next_state = S_PROCESS;
                end else begin
                    next_state = S_IDLE;
                end
            end
            S_PROCESS: begin
                next_state = S_DONE;
            end
            S_DONE: begin
                next_state = S_IDLE;
            end
            default: begin
                next_state = S_IDLE;
            end
        endcase
    end

    // Output logic
    assign done = (current_state == S_DONE);

endmodule