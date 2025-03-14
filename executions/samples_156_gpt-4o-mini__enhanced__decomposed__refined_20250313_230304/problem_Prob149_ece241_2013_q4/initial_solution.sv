```verilog
[BEGIN]
module TopModule (
    input logic clk,                   // Clock input
    input logic reset,                 // Active-high synchronous reset
    input logic [2:0] s,               // Sensor inputs (3 bits)
    output logic fr2,                  // Flow rate output 2
    output logic fr1,                  // Flow rate output 1
    output logic fr0,                  // Flow rate output 0
    output logic dfr                   // Supplemental flow valve control
);

always @(posedge clk) begin
    if (reset) begin
        fr2 <= 1'b1; // Reset state
        fr1 <= 1'b1;
        fr0 <= 1'b1;
        dfr <= 1'b0; // No supplemental flow when reset
    end else begin
        case (s)
            3'b111: begin // Above s[2]
                fr2 <= 1'b0; 
                fr1 <= 1'b0;
                fr0 <= 1'b0;
                dfr <= 1'b0; 
            end
            3'b110: begin // Between s[2] and s[1]
                fr2 <= 1'b0; 
                fr1 <= 1'b0;
                fr0 <= 1'b1;
                dfr <= 1'b0; 
            end
            3'b100: begin // Between s[1] and s[0]
                fr2 <= 1'b0; 
                fr1 <= 1'b1;
                fr0 <= 1'b1;
                dfr <= 1'b0; 
            end
            3'b000: begin // Below s[0]
                fr2 <= 1'b1; 
                fr1 <= 1'b1;
                fr0 <= 1'b1;
                dfr <= 1'b1; 
            end
            default: begin
                fr2 <= 1'b1; 
                fr1 <= 1'b1;
                fr0 <= 1'b1;
                dfr <= 1'b0; 
            end
        endcase
    end
end

endmodule
[DONE]
```