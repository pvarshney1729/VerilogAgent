[BEGIN]  
module TopModule (  
    input logic clk,  
    input logic a,  
    output logic [2:0] q  
);  
    logic [2:0] state;  
    logic reset_n; // Add a reset signal for synchronous reset

    always @(posedge clk) begin  
        if (!reset_n) begin  
            state <= 3'b000; // Reset state  
        end else begin  
            case (state)  
                3'b000: state <= (a == 1'b1) ? 3'b000 : 3'b001; // State 0  
                3'b001: state <= (a == 1'b0) ? 3'b010 : 3'b001; // State 1  
                3'b010: state <= (a == 1'b0) ? 3'b011 : 3'b010; // State 2  
                3'b011: state <= (a == 1'b1) ? 3'b100 : 3'b011; // State 3  
                3'b100: state <= (a == 1'b0) ? 3'b101 : 3'b100; // State 4  
                3'b101: state <= (a == 1'b0) ? 3'b110 : 3'b101; // State 5  
                3'b110: state <= (a == 1'b0) ? 3'b000 : 3'b110; // State 6  
                default: state <= 3'b000; // Default to state 0  
            endcase  
        end  
    end  

    assign q = state;  

endmodule  
[DONE]