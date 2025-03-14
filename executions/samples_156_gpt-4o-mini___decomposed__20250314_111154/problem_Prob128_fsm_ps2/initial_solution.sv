module TopModule (
    input logic clk,
    input logic reset,
    input logic [7:0] in,
    output logic done
);

    typedef enum logic [2:0] {
        IDLE            = 3'b000,
        EXPECT_BYTE1    = 3'b001,
        EXPECT_BYTE2    = 3'b010,
        EXPECT_BYTE3    = 3'b011,
        DONE            = 3'b100
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
            if (current_state == DONE) begin
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
                    next_state = EXPECT_BYTE1;
                    byte_count = 2'b00;
                end else begin
                    next_state = IDLE;
                end
            end
            EXPECT_BYTE1: begin
                byte_count = byte_count + 1'b1;
                next_state = EXPECT_BYTE2;
            end
            EXPECT_BYTE2: begin
                byte_count = byte_count + 1'b1;
                next_state = EXPECT_BYTE3;
            end
            EXPECT_BYTE3: begin
                if (byte_count == 2'b10) begin
                    next_state = DONE;
                end else begin
                    next_state = EXPECT_BYTE1; // Loop back to expect next message
                end
            end
            DONE: begin
                next_state = IDLE; // Transition back to IDLE
            end
            default: next_state = IDLE;
        endcase
    end

endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly