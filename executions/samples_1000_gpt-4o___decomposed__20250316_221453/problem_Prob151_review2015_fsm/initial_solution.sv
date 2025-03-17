module TopModule(
    input logic clk,
    input logic reset,
    input logic data,
    input logic done_counting,
    input logic ack,
    output logic shift_ena,
    output logic counting,
    output logic done
);

    typedef enum logic [2:0] {
        SEARCH = 3'b000,
        LOAD = 3'b001,
        COUNTING = 3'b010,
        DONE = 3'b011
    } state_t;

    state_t state, next_state;
    logic [3:0] pattern_shift;
    logic [1:0] load_counter;

    always_ff @(posedge clk) begin
        if (reset) begin
            state <= SEARCH;
            pattern_shift <= 4'b0000;
            load_counter <= 2'b00;
        end else begin
            state <= next_state;
            if (state == SEARCH) begin
                pattern_shift <= {pattern_shift[2:0], data};
            end
            if (state == LOAD) begin
                load_counter <= load_counter + 1;
            end else begin
                load_counter <= 2'b00;
            end
        end
    end

    always_comb begin
        next_state = state;
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;

        case (state)
            SEARCH: begin
                if (pattern_shift == 4'b1101) begin
                    next_state = LOAD;
                end
            end
            LOAD: begin
                shift_ena = 1'b1;
                if (load_counter == 2'b11) begin
                    next_state = COUNTING;
                end
            end
            COUNTING: begin
                counting = 1'b1;
                if (done_counting) begin
                    next_state = DONE;
                end
            end
            DONE: begin
                done = 1'b1;
                if (ack) begin
                    next_state = SEARCH;
                end
            end
        endcase
    end

endmodule