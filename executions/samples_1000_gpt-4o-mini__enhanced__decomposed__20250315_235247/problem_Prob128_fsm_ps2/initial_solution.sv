module TopModule(
    input logic clk,
    input logic reset,
    input logic [7:0] in,
    output logic done
);
    typedef enum logic [1:0] {
        IDLE   = 2'b00,
        BYTE1  = 2'b01,
        BYTE2  = 2'b10,
        DONE   = 2'b11
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    always_comb begin
        case (current_state)
            IDLE: begin
                if (in[3] == 1) begin
                    next_state = BYTE1;
                end else begin
                    next_state = IDLE;
                end
            end
            BYTE1: begin
                next_state = BYTE2;
            end
            BYTE2: begin
                next_state = DONE;
            end
            DONE: begin
                next_state = IDLE; // Reset to IDLE after signaling done
            end
            default: next_state = IDLE;
        endcase
    end

    assign done = (current_state == DONE);

endmodule