```verilog
module TopModule (
    input logic clk,
    input logic reset,
    input logic [7:0] in,
    output logic [23:0] out_bytes,
    output logic done
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        RECEIVE = 2'b01,
        DONE = 2'b10
    } state_t;

    state_t current_state, next_state;
    logic [1:0] byte_count;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            out_bytes <= 24'h000000;
            done <= 1'b0;
            byte_count <= 2'b00;
        end else begin
            current_state <= next_state;
            if (current_state == RECEIVE) begin
                out_bytes <= {out_bytes[15:0], in};
                byte_count <= byte_count + 1;
            end
            if (current_state == DONE) begin
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
                if (in[3] == 1'b1) begin
                    next_state = RECEIVE;
                end
            end
            RECEIVE: begin
                if (byte_count == 2'b10) begin
                    next_state = DONE;
                end
            end
            DONE: begin
                next_state = IDLE;
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule
```