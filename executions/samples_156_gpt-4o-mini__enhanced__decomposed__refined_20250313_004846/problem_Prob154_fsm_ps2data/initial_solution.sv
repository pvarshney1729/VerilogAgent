```verilog
[BEGIN]
module TopModule (
    input logic clk,
    input logic reset,
    input logic [7:0] in,
    output logic [23:0] out_bytes,
    output logic done
);

    // State encoding
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        BYTE2 = 2'b01,
        BYTE3 = 2'b10
    } state_t;

    // State registers
    state_t current_state, next_state;

    // State transition and output logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            out_bytes <= 24'b0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == IDLE && next_state == BYTE2) begin
                out_bytes[23:16] <= in; // Capture first byte
            end else if (current_state == BYTE2 && next_state == BYTE3) begin
                out_bytes[15:8] <= in; // Capture second byte
            end else if (current_state == BYTE3) begin
                out_bytes[7:0] <= in; // Capture third byte
                done <= 1'b1; // Assert done
            end else begin
                done <= 1'b0; // Deassert done
            end
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state; // Default to hold state
        case (current_state)
            IDLE: begin
                if (in[3] == 1'b1) begin
                    next_state = BYTE2;
                end
            end
            BYTE2: begin
                next_state = BYTE3;
            end
            BYTE3: begin
                next_state = IDLE;
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule
[DONE]
```