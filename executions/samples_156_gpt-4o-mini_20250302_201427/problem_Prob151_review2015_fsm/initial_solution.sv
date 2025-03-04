module TopModule (
    input  logic clk,           
    input  logic reset,         
    input  logic data,          
    input  logic done_counting, 
    input  logic ack,           
    output logic shift_ena,     
    output logic counting,       
    output logic done            
);

    typedef enum logic [1:0] {
        IDLE,
        SHIFT,
        COUNT,
        DONE
    } state_t;

    state_t current_state, next_state;
    logic [3:0] pattern_buffer;
    logic [1:0] shift_count;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            shift_ena <= 1'b0;
            counting <= 1'b0;
            done <= 1'b0;
            pattern_buffer <= 4'b0;
            shift_count <= 2'b0;
        end else begin
            current_state <= next_state;
            if (current_state == SHIFT) begin
                shift_ena <= 1'b1;
                shift_count <= shift_count + 1;
            end else if (shift_count == 2'b11) begin
                shift_ena <= 1'b0;
                counting <= 1'b1;
            end else if (counting && done_counting) begin
                counting <= 1'b0;
                done <= 1'b1;
            end else if (done && ack) begin
                done <= 1'b0;
            end
        end
    end

    always_comb begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                if (pattern_buffer == 4'b1101) begin
                    next_state = SHIFT;
                    pattern_buffer <= {pattern_buffer[2:0], data};
                end else begin
                    pattern_buffer <= {pattern_buffer[2:0], data};
                end
            end
            SHIFT: begin
                if (shift_count == 2'b11) begin
                    next_state = COUNT;
                end
            end
            COUNT: begin
                if (done_counting) begin
                    next_state = DONE;
                end
            end
            DONE: begin
                if (ack) begin
                    next_state = IDLE;
                end
            end
        endcase
    end

endmodule