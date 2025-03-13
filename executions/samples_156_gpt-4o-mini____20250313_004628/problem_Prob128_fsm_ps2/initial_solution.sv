module TopModule (
    input logic clk,
    input logic reset,
    input logic [7:0] in,
    output logic done
);

    typedef enum logic [1:0] {
        IDLE,
        WAIT_FOR_FIRST_BYTE,
        RECEIVE_BYTE_1,
        RECEIVE_BYTE_2,
        RECEIVE_BYTE_3
    } state_t;

    state_t current_state, next_state;
    logic [1:0] byte_count;

    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            byte_count <= 2'b00;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == RECEIVE_BYTE_3) begin
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end

    always @(*) begin
        case (current_state)
            IDLE: begin
                if (in[3] == 1'b1) begin
                    next_state = RECEIVE_BYTE_1;
                    byte_count = 2'b01;
                end else begin
                    next_state = IDLE;
                end
            end
            RECEIVE_BYTE_1: begin
                next_state = RECEIVE_BYTE_2;
                byte_count = 2'b10;
            end
            RECEIVE_BYTE_2: begin
                next_state = RECEIVE_BYTE_3;
                byte_count = 2'b11;
            end
            RECEIVE_BYTE_3: begin
                next_state = IDLE;
                byte_count = 2'b00;
            end
            default: begin
                next_state = IDLE;
                byte_count = 2'b00;
            end
        endcase
    end

endmodule