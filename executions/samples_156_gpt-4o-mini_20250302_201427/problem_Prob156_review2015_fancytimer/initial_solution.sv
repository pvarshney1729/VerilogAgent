module timer (
    input logic clk,
    input logic reset,
    input logic data,
    input logic ack,
    output logic [3:0] count,
    output logic counting,
    output logic done
);

    logic [3:0] delay;
    logic [3:0] current_count;
    logic [1:0] state, next_state;
    
    parameter IDLE = 2'b00, LOAD_DELAY = 2'b01, COUNTING = 2'b10, DONE = 2'b11;

    always @(posedge clk) begin
        if (reset) begin
            current_count <= 4'b0000;
            counting <= 1'b0;
            done <= 1'b0;
            state <= IDLE;
        end else begin
            state <= next_state;
            if (state == COUNTING) begin
                if (current_count > 0) begin
                    current_count <= current_count - 1;
                end else begin
                    done <= 1'b1;
                    counting <= 1'b0;
                end
            end
        end
    end

    always @(*) begin
        case (state)
            IDLE: begin
                counting = 1'b0;
                done = 1'b0;
                if (data == 1'b1) begin
                    // Assume we have detected '1101' and load delay
                    delay = 4'b1010; // Example value for delay
                    next_state = LOAD_DELAY;
                end else begin
                    next_state = IDLE;
                end
            end
            LOAD_DELAY: begin
                current_count = delay + 1; // Set count to delay + 1
                counting = 1'b1;
                next_state = COUNTING;
            end
            COUNTING: begin
                counting = 1'b1;
                next_state = COUNTING;
            end
            DONE: begin
                counting = 1'b0;
                if (ack) begin
                    next_state = IDLE;
                end else begin
                    next_state = DONE;
                end
            end
            default: next_state = IDLE;
        endcase
    end

    assign count = current_count;

endmodule