module TopModule (
    input logic        in,            
    input logic [9:0]  state,         
    output logic [9:0] next_state,    
    output logic       out1,          
    output logic       out2           
);

    always @(*) begin
        next_state = 10'b0; // Default to all zeros
        if (state == 10'b0) begin
            next_state[0] = 1'b1; // Default to S0
        end else begin
            case (1'b1) // Prioritize the lowest indexed active state
                state[0]: next_state = (in ? 10'b0000000001 : 10'b0000000001); // S0
                state[1]: next_state = (in ? 10'b0000000010 : 10'b0000000001); // S1
                state[2]: next_state = (in ? 10'b0000000100 : 10'b0000000001); // S2
                state[3]: next_state = (in ? 10'b0000001000 : 10'b0000000001); // S3
                state[4]: next_state = (in ? 10'b0000010000 : 10'b0000000001); // S4
                state[5]: next_state = (in ? 10'b0000100000 : 10'b0000100000); // S5
                state[6]: next_state = (in ? 10'b0001000000 : 10'b0000001000); // S6
                state[7]: next_state = (in ? 10'b0000000000 : 10'b0000000000); // S7
                state[8]: next_state = (in ? 10'b0000000001 : 10'b0000000001); // S8
                state[9]: next_state = (in ? 10'b0000000001 : 10'b0000000001); // S9
            endcase
        end
    end

    assign out1 = (state[8] || state[9]) ? 1'b1 : 1'b0; // Output logic for out1
    assign out2 = (state[7] || state[9]) ? 1'b1 : 1'b0; // Output logic for out2

endmodule