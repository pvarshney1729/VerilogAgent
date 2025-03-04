module TopModule(
    input logic clk,          
    input logic rst_n,        
    input logic d,            
    input logic done_counting, 
    input logic ack,          
    input logic [9:0] state,  
    output logic B3_next,     
    output logic S_next,      
    output logic S1_next,     
    output logic Count_next,  
    output logic Wait_next,   
    output logic done,        
    output logic counting,    
    output logic shift_ena    
);

    typedef enum logic [9:0] {
        S      = 10'b0000000001,
        S1     = 10'b0000000010,
        S11    = 10'b0000000100,
        S110   = 10'b0000001000,
        B0     = 10'b0000010000,
        B1     = 10'b0000100000,
        B2     = 10'b0001000000,
        B3     = 10'b0010000000,
        Count  = 10'b0100000000,
        Wait   = 10'b1000000000
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            current_state <= S;
        else
            current_state <= next_state;
    end

    always_comb begin
        next_state = current_state; // Default to hold state
        B3_next = 1'b0;
        S_next = 1'b0;
        S1_next = 1'b0;
        Count_next = 1'b0;
        Wait_next = 1'b0;
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;

        case (current_state)
            S: begin
                if (d) next_state = S1;
            end
            S1: begin
                if (d) next_state = S11;
            end
            S11: begin
                if (d) next_state = S110;
            end
            S110: begin
                if (d) next_state = B0;
            end
            B0: begin
                shift_ena = 1'b1;
                if (ack) next_state = B1;
            end
            B1: begin
                shift_ena = 1'b1;
                if (ack) next_state = B2;
            end
            B2: begin
                shift_ena = 1'b1;
                if (ack) next_state = B3;
            end
            B3: begin
                shift_ena = 1'b1;
                if (ack) next_state = Count;
            end
            Count: begin
                counting = 1'b1;
                if (done_counting) next_state = Wait;
            end
            Wait: begin
                done = 1'b1;
            end
        endcase
    end

endmodule