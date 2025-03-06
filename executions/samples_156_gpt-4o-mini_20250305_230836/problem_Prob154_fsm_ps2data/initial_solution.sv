module TopModule (
    input logic clk,
    input logic reset,
    input logic [7:0] in,
    output logic [23:0] out_bytes,
    output logic done
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        BYTE1 = 2'b01,
        BYTE2 = 2'b10,
        BYTE3 = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [23:0] bytes;
    
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            bytes <= 24'hXXXXXX;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == BYTE3) begin
                done <= 1'b1;
            end else if (current_state == IDLE) begin
                done <= 1'b0;
            end
        end
    end

    always_ff @(posedge clk) begin
        if (reset) begin
            bytes <= 24'hXXXXXX;
        end else begin
            case (current_state)
                IDLE: if (in[3]) begin
                    bytes[23:16] <= in;
                    next_state <= BYTE1;
                end
                BYTE1: begin
                    bytes[15:8] <= in;
                    next_state <= BYTE2;
                end
                BYTE2: begin
                    bytes[7:0] <= in;
                    next_state <= BYTE3;
                end
                BYTE3: next_state <= IDLE;
            endcase
        end
    end

    assign out_bytes = bytes;

endmodule