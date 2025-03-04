module TopModule (
    input logic clk,
    input logic reset,
    input logic data,
    input logic done_counting,
    input logic ack,
    output logic shift_ena,
    output logic counting,
    output logic done
);

    typedef enum logic [1:0] {
        SEARCHING,
        SHIFT,
        COUNTING,
        DONE
    } state_t;

    state_t current_state, next_state;
    logic [3:0] shift_counter;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= SEARCHING;
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
            shift_counter <= 0;
        end else begin
            current_state <= next_state;
            if (current_state == SHIFT) begin
                if (shift_counter < 4) begin
                    shift_counter <= shift_counter + 1;
                end else begin
                    shift_counter <= 0;
                end
            end else begin
                shift_counter <= 0;
            end
        end
    end

    always_ff @(posedge clk) begin
        case (current_state)
            SEARCHING: begin
                shift_ena <= 0;
                counting <= 0;
                done <= 0;
                if (data == 1 && /* previous data bits indicate pattern */) begin
                    next_state <= SHIFT;
                end else begin
                    next_state <= SEARCHING;
                end
            end
            SHIFT: begin
                shift_ena <= 1;
                if (shift_counter == 3) begin
                    next_state <= COUNTING;
                end else begin
                    next_state <= SHIFT;
                end
            end
            COUNTING: begin
                counting <= 1;
                if (done_counting) begin
                    next_state <= DONE;
                end else begin
                    next_state <= COUNTING;
                end
            end
            DONE: begin
                done <= 1;
                if (ack) begin
                    next_state <= SEARCHING;
                end else begin
                    next_state <= DONE;
                end
            end
        endcase
    end

endmodule