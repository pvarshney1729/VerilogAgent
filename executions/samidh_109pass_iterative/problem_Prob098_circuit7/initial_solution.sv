module TopModule(
    input logic clk,
    input logic a,
    output logic q
);

    initial begin
        q = 1'b0;  // Initial state
    end
    
    always @(posedge clk) begin
        if (a) begin
            q <= ~q;
        end
    end
endmodule