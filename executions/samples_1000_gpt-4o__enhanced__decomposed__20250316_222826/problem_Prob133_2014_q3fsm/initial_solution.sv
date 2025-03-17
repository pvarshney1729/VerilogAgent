module TopModule (
    input logic clk,
    input logic reset,
    input logic s,
    input logic w,
    output logic z
);

    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01
    } state_t;

    state_t current_state, next_state;
    logic [1:0] cycle_count;
    logic [1:0] w_count;

    // State transition and output logic
    always @(posedge clk) begin
        if (reset) begin
            current_state <= A;
            cycle_count <= 2'b00;
            w_count <= 2'b00;
            z <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == B) begin
                if (cycle_count < 2'b10) begin
                    cycle_count <= cycle_count + 1;
                    if (w) begin
                        w_count <= w_count + 1;
                    end
                end else begin
                    z <= (w_count == 2'b10) ? 1'b1 : 1'b0;
                    cycle_count <= 2'b00;
                    w_count <= 2'b00;
                end
            end
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            A: begin
                if (s) next_state = B;
                else next_state = A;
            end
            B: begin
                next_state = B; // Remain in B, as the task is to handle transitions based on 'w'
            end
            default: next_state = A;
        endcase
    end

endmodule