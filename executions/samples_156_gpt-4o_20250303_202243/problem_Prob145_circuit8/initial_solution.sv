module TopModule (
    input wire clock,
    input wire a,
    output reg p = 1'b0,
    output reg q = 1'b0
);

    always @(posedge clock) begin
        if (a) 
            p <= 1'b1;
        else 
            p <= 1'b0;
        
        q <= 1'b0; // Reset q on rising edge
    end

    always @(negedge clock) begin
        if (p)
            q <= 1'b1;
    end

endmodule