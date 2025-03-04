module TopModule (
    input  logic        clk,           // Clock signal, positive edge triggered
    input  logic        reset,         // Synchronous active-high reset
    input  logic [7:0]  in,            // 8-bit input byte stream, unsigned
    output logic [23:0] out_bytes,     // 24-bit output message, unsigned
    output logic        done           // Done signal, asserted upon message completion
);

    typedef enum logic [2:0] {
        IDLE    = 3'b000,
        BYTE_1  = 3'b001,
        BYTE_2  = 3'b010,
        BYTE_3  = 3'b011,
        DONE    = 3'b100
    } state_t;

    state_t current_state, next_state;
    logic [23:0] temp_bytes;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            out_bytes <= 24'b0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == DONE) begin
                out_bytes <= temp_bytes;
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                if (in[3] == 1'b1) begin
                    next_state = BYTE_1;
                end
            end
            BYTE_1: begin
                temp_bytes[23:16] = in;
                next_state = BYTE_2;
            end
            BYTE_2: begin
                temp_bytes[15:8] = in;
                next_state = BYTE_3;
            end
            BYTE_3: begin
                temp_bytes[7:0] = in;
                next_state = DONE;
            end
            DONE: begin
                if (in[3] == 1'b1) begin
                    next_state = BYTE_1;
                end else begin
                    next_state = IDLE;
                end
            end
            default: next_state = IDLE;
        endcase
    end

endmodule