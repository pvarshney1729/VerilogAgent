module TopModule (
    input logic clk,
    input logic areset,
    input logic x,
    output logic z
);
    typedef enum logic [1:0] {
        IDLE,         
        INPUT,        
        COMPLEMENT,   
        OUTPUT        
    } state_t;

    state_t current_state, next_state;
    logic [31:0] shift_reg; 
    logic [31:0] two_complement;
    logic [7:0] count; 

    always @(posedge clk) begin
        if (areset) begin
            current_state <= IDLE;
            count <= 0;
            shift_reg <= 0;
            z <= 0;
        end else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        case (current_state)
            IDLE: begin
                if (!areset) begin
                    next_state = INPUT;
                end else begin
                    next_state = IDLE;
                end
            end
            INPUT: begin
                if (count < 32) begin
                    next_state = INPUT;
                end else begin
                    next_state = COMPLEMENT;
                end
            end
            COMPLEMENT: begin
                next_state = OUTPUT;
            end
            OUTPUT: begin
                next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

    always @(posedge clk) begin
        if (current_state == INPUT) begin
            shift_reg <= {shift_reg[30:0], x}; 
            count <= count + 1;
        end else if (current_state == COMPLEMENT) begin
            two_complement <= ~shift_reg + 1; 
        end else if (current_state == OUTPUT) begin
            z <= two_complement[0]; 
        end
    end
endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly