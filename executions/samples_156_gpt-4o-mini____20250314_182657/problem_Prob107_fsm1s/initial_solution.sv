module TopModule (
    input logic clk,
    input logic reset,
    input logic in,
    output logic out
);

    typedef enum logic [1:0] {
        B = 2'b00,
        A = 2'b01
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            B: begin
                if (in == 1'b0) 
                    next_state = A;
                else 
                    next_state = B;
                out = 1'b1;
            end
            A: begin
                if (in == 1'b0) 
                    next_state = B;
                else 
                    next_state = A;
                out = 1'b0;
            end
            default: begin
                next_state = B;
                out = 1'b1;
            end
        endcase
    end

    // Sequential logic with synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            current_state <= B;
        end else begin
            current_state <= next_state;
        end
    end

    // Initialize output
    assign out = (current_state == B) ? 1'b1 : 1'b0;

endmodule