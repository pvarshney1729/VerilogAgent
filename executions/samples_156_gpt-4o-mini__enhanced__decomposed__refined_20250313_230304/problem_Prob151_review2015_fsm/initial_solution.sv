[BEGIN]
```verilog
module TopModule (
    input logic clk,          
    input logic reset,        
    input logic [3:0] data,   
    input logic done_counting, 
    input logic ack,          
    output logic shift_ena,    
    output logic counting,      
    output logic done          
);

    // State encoding
    typedef enum logic [1:0] {
        SEARCHING = 2'b00,
        SHIFTING  = 2'b01,
        COUNTING  = 2'b10,
        DONE      = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic [2:0] shift_counter;

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= SEARCHING;
            shift_ena <= 1'b0;
            counting <= 1'b0;
            done <= 1'b0;
            shift_counter <= 3'b000;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        // Default outputs
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;
        next_state = current_state; // Default to hold state

        case (current_state)
            SEARCHING: begin
                if (data == 4'b1101) begin
                    next_state = SHIFTING;
                end
            end
            
            SHIFTING: begin
                shift_ena = 1'b1;
                if (shift_counter < 3) begin
                    shift_counter = shift_counter + 1;
                    next_state = SHIFTING;
                end else begin
                    shift_counter = 3'b000;
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
                    next_state = SEARCHING;
                end
            end
            
            default: next_state = SEARCHING;
        endcase
    end
endmodule
```
[DONE]