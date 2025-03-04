module TopModule (
    input logic clk,             // Clock signal, active on the positive edge
    input logic reset,           // Active high synchronous reset
    input logic [7:0] in,        // 8-bit input byte stream
    output logic done            // Output signal indicating message completion
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        BYTE_1_RECEIVED = 2'b01,
        BYTE_3_RECEIVED = 2'b10
    } state_t;

    state_t current_state, next_state;
    logic [1:0] byte_count;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            byte_count <= 2'b00;
        end else begin
            current_state <= next_state;
            if (current_state == BYTE_1_RECEIVED || current_state == BYTE_3_RECEIVED) begin
                byte_count <= byte_count + 1;
            end else begin
                byte_count <= 2'b00;
            end
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state;
        done = 1'b0;
        case (current_state)
            IDLE: begin
                if (in[3] == 1'b1) begin
                    next_state = BYTE_1_RECEIVED;
                end
            end
            BYTE_1_RECEIVED: begin
                if (byte_count == 2'b10) begin
                    next_state = BYTE_3_RECEIVED;
                end
            end
            BYTE_3_RECEIVED: begin
                done = 1'b1;
                next_state = IDLE;
            end
        endcase
    end

endmodule