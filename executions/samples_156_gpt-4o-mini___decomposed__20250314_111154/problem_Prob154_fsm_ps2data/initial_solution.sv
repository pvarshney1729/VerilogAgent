module TopModule (
    input logic clk,
    input logic reset,
    input logic [7:0] in,
    output logic [23:0] out_bytes,
    output logic done
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        BYTE_1 = 2'b01,
        BYTE_2 = 2'b10,
        BYTE_3 = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [1:0] byte_count;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            byte_count <= 0;
            out_bytes <= 24'b0;
            done <= 0;
        end else begin
            current_state <= next_state;
        end
    end

    always_comb begin
        next_state = current_state;
        done = 0;
        
        case (current_state)
            IDLE: begin
                if (in[3] == 1'b1) begin
                    next_state = BYTE_1;
                    byte_count = 1;
                    out_bytes[23:16] = in;
                end
            end
            
            BYTE_1: begin
                next_state = BYTE_2;
                out_bytes[15:8] = in;
                byte_count = byte_count + 1;
            end
            
            BYTE_2: begin
                next_state = BYTE_3;
                out_bytes[7:0] = in;
                byte_count = byte_count + 1;
            end
            
            BYTE_3: begin
                done = 1;
                if (in[3] == 1'b1) begin
                    next_state = BYTE_1;
                    out_bytes[23:16] = in;
                    byte_count = 1;
                end else begin
                    next_state = IDLE;
                    byte_count = 0;
                end
            end
            
            default: next_state = IDLE;
        endcase
    end

endmodule