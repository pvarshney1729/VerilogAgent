module pattern_counter (
    input logic clk,
    input logic reset,
    input logic data,
    input logic ack,
    output logic [3:0] count,
    output logic counting,
    output logic done
);

    typedef enum logic [1:0] {
        SEARCH = 2'b00,
        CONFIGURE = 2'b01,
        COUNT = 2'b10,
        COMPLETE = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [3:0] delay;
    logic [3:0] bit_counter;
    logic [9:0] cycle_counter;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= SEARCH;
            count <= 4'b0000;
            counting <= 1'b0;
            done <= 1'b0;
            delay <= 4'b0000;
            bit_counter <= 4'b0000;
            cycle_counter <= 10'b0000000000;
        end else begin
            current_state <= next_state;
        end
    end

    always_ff @(posedge clk) begin
        case (current_state)
            SEARCH: begin
                if (data == 1'b1 && bit_counter == 4'b0000) begin
                    bit_counter <= bit_counter + 1;
                end else if (data == 1'b1 && bit_counter == 4'b0011) begin
                    next_state <= CONFIGURE;
                    bit_counter <= 4'b0000;
                end else if (data == 1'b0 && bit_counter != 4'b0000) begin
                    bit_counter <= 4'b0000;
                end
            end

            CONFIGURE: begin
                delay <= {delay[2:0], data};
                bit_counter <= bit_counter + 1;
                if (bit_counter == 4'b0011) begin
                    next_state <= COUNT;
                    count <= delay;
                    counting <= 1'b1;
                    cycle_counter <= 10'b0000000000;
                end
            end

            COUNT: begin
                if (cycle_counter == 10'd999) begin
                    cycle_counter <= 10'b0000000000;
                    if (count == 4'b0000) begin
                        next_state <= COMPLETE;
                        counting <= 1'b0;
                        done <= 1'b1;
                    end else begin
                        count <= count - 1;
                    end
                end else begin
                    cycle_counter <= cycle_counter + 1;
                end
            end

            COMPLETE: begin
                if (ack) begin
                    next_state <= SEARCH;
                    done <= 1'b0;
                end
            end

            default: next_state <= SEARCH;
        endcase
    end

    always_comb begin
        next_state = current_state;
    end

endmodule