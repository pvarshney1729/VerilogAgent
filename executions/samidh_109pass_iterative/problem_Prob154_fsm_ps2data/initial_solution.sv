module TopModule (
    input logic clk,          // Clock signal, positive edge-triggered
    input logic reset,        // Synchronous active high reset
    input logic [7:0] in,     // 8-bit input byte stream, unsigned
    output logic [23:0] out_bytes, // 24-bit output, unsigned
    output logic done         // Signals completion of a message reception
);

    // State encoding
    typedef enum logic [1:0] {
        IDLE    = 2'b00,
        STATE_1 = 2'b01,
        STATE_2 = 2'b10,
        STATE_3 = 2'b11
    } state_t;

    state_t current_state, next_state;

    // Sequential logic for state transition and output logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            out_bytes <= 24'b0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            case (current_state)
                STATE_1: out_bytes[23:16] <= in;
                STATE_2: out_bytes[15:8] <= in;
                STATE_3: begin
                    out_bytes[7:0] <= in;
                    done <= 1'b1;
                end
                default: done <= 1'b0;
            endcase
        end
    end

    // Combinational logic for next state logic
    always_comb begin
        next_state = current_state;
        case (current_state)
            IDLE: if (in[3]) next_state = STATE_1;
            STATE_1: next_state = STATE_2;
            STATE_2: next_state = STATE_3;
            STATE_3: next_state = IDLE;
        endcase
    end

endmodule