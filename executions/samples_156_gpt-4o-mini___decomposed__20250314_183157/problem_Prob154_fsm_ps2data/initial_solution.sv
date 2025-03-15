module TopModule (
    input logic clk,
    input logic reset,
    input logic [7:0] in,
    output logic [23:0] out_bytes,
    output logic done
);

    typedef enum logic [1:0] {
        WAIT_FOR_BYTE = 2'b00,
        PROCESS_BYTE1 = 2'b01,
        PROCESS_BYTE2 = 2'b10,
        PROCESS_BYTE3 = 2'b11
    } fsm_state_t;

    fsm_state_t current_state, next_state;
    logic [23:0] out_bytes_reg;
    logic [1:0] byte_count;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= WAIT_FOR_BYTE;
            out_bytes_reg <= 24'b0;
            done <= 1'b0;
            byte_count <= 2'b0;
        end else begin
            current_state <= next_state;
            if (current_state == PROCESS_BYTE1) begin
                out_bytes_reg[23:16] <= in; // Store first byte
            end else if (current_state == PROCESS_BYTE2) begin
                out_bytes_reg[15:8] <= in; // Store second byte
            end else if (current_state == PROCESS_BYTE3) begin
                out_bytes_reg[7:0] <= in; // Store third byte
                done <= 1'b1; // Signal done after receiving 3 bytes
            end else begin
                done <= 1'b0; // Clear done signal
            end
        end
    end

    always_comb begin
        case (current_state)
            WAIT_FOR_BYTE: 
                if (in[3]) 
                    next_state = PROCESS_BYTE1;
                else 
                    next_state = WAIT_FOR_BYTE;

            PROCESS_BYTE1: 
                next_state = PROCESS_BYTE2;
            
            PROCESS_BYTE2: 
                next_state = PROCESS_BYTE3;

            PROCESS_BYTE3: 
                next_state = WAIT_FOR_BYTE;

            default: 
                next_state = WAIT_FOR_BYTE;
        endcase
    end

    assign out_bytes = out_bytes_reg;

endmodule