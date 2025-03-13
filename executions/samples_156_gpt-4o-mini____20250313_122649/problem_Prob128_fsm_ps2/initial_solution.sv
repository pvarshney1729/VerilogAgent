module TopModule (
    input logic clk,
    input logic reset,
    input logic [7:0] in,
    output logic done
);

    typedef enum logic [1:0] {
        IDLE,
        BYTE1,
        BYTE2,
        BYTE3
    } state_t;

    state_t current_state, next_state;

    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        case (current_state)
            IDLE: begin
                if (in[3] == 1'b1) begin
                    next_state = BYTE1;
                end else begin
                    next_state = IDLE;
                end
                done = 1'b0;
            end
            
            BYTE1: begin
                next_state = BYTE2;
                done = 1'b0;
            end
            
            BYTE2: begin
                next_state = BYTE3;
                done = 1'b0;
            end
            
            BYTE3: begin
                next_state = IDLE;
                done = 1'b1;
            end
            
            default: begin
                next_state = IDLE;
                done = 1'b0;
            end
        endcase
    end

endmodule