module TopModule (
    input logic clk,
    input logic reset,
    input logic data_in,
    output logic discard,
    output logic flag,
    output logic error
);

    typedef enum logic [1:0] {
        S_IDLE = 2'b00,
        S_DISCARD = 2'b01,
        S_FLAG = 2'b10,
        S_ERROR = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            S_IDLE: begin
                if (data_in == 1'b1) 
                    next_state = S_DISCARD;
                else 
                    next_state = S_IDLE;
            end
            S_DISCARD: begin
                if (data_in == 1'b0) 
                    next_state = S_FLAG;
                else 
                    next_state = S_ERROR;
            end
            S_FLAG: begin
                if (data_in == 1'b1) 
                    next_state = S_ERROR;
                else 
                    next_state = S_IDLE;
            end
            S_ERROR: begin
                next_state = S_IDLE; // Reset to IDLE after error
            end
            default: next_state = S_IDLE;
        endcase
    end

    // State register with synchronous reset
    always @(posedge clk) begin
        if (reset) 
            current_state <= S_IDLE;
        else 
            current_state <= next_state;
    end

    // Output logic
    assign discard = (current_state == S_DISCARD);
    assign flag = (current_state == S_FLAG);
    assign error = (current_state == S_ERROR);

endmodule