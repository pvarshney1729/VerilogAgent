module TopModule (
    input logic clk,
    input logic areset,
    input logic x,
    output logic z
);
    typedef enum logic [1:0] {
        S_IDLE = 2'b00,  
        S_READ = 2'b01,  
        S_COMPLEMENT = 2'b10,  
        S_OUTPUT = 2'b11  
    } state_t;

    state_t current_state, next_state;
    logic [31:0] input_value; 
    logic [31:0] twos_complement;
    logic [5:0] bit_count; 
    logic processing;

    always_ff @(posedge clk) begin
        if (areset) begin
            current_state <= S_IDLE;
            input_value <= 0;
            twos_complement <= 0;
            bit_count <= 0;
            processing <= 0;
        end else begin
            current_state <= next_state;
            if (current_state == S_OUTPUT) begin
                z <= twos_complement[bit_count];
            end
        end
    end

    always_comb begin
        case (current_state)
            S_IDLE: begin
                if (!areset) begin
                    next_state = S_READ;
                end else begin
                    next_state = S_IDLE;
                end
            end
            S_READ: begin
                input_value[bit_count] = x;
                if (bit_count == 31) begin
                    next_state = S_COMPLEMENT;
                end else begin
                    next_state = S_READ;
                end
            end
            S_COMPLEMENT: begin
                twos_complement = ~input_value + 1;
                next_state = S_OUTPUT;
            end
            S_OUTPUT: begin
                if (bit_count < 31) begin
                    bit_count = bit_count + 1;
                    next_state = S_OUTPUT;
                end else begin
                    next_state = S_IDLE;
                end
            end
            default: next_state = S_IDLE;
        endcase
    end
endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly