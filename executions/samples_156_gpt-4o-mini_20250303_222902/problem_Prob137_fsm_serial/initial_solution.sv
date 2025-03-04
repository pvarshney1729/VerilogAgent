module TopModule (
    input  logic clk,       // Clock signal
    input  logic reset,     // Active-high synchronous reset
    input  logic in,        // Serial data input
    output logic done       // Byte received indication
);

    typedef enum logic [2:0] {
        IDLE   = 3'b000,
        START  = 3'b001,
        DATA   = 3'b010,
        STOP   = 3'b011,
        ERROR  = 3'b100
    } state_t;

    state_t current_state, next_state;
    logic [7:0] data;
    logic [2:0] bit_count;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            done <= 1'b0;
            bit_count <= 3'b000;
            data <= 8'b00000000;
        end else begin
            current_state <= next_state;
            if (current_state == STOP) begin
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end

    always_comb begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                if (in == 1'b0) begin
                    next_state = START;
                end
            end
            START: begin
                next_state = DATA;
                bit_count = 3'b000;
            end
            DATA: begin
                if (bit_count < 3'b111) begin
                    data[bit_count] = in;
                    bit_count = bit_count + 1;
                end else begin
                    next_state = STOP;
                end
            end
            STOP: begin
                if (in == 1'b1) begin
                    next_state = IDLE;
                end else begin
                    next_state = ERROR;
                end
            end
            ERROR: begin
                if (in == 1'b1) begin
                    next_state = IDLE;
                end
            end
        endcase
    end

endmodule