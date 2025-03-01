```verilog
module TopModule (
    input logic clock,
    input logic reset_n, // Active-low asynchronous reset
    input logic a,
    output logic p,
    output logic q
);

    always_ff @(posedge clock or negedge reset_n) begin
        if (!reset_n) begin
            p <= 1'b0;
            q <= 1'b0;
        end else begin
            if (a) begin
                if (!p) begin
                    p <= 1'b1;
                end
            end else begin
                p <= 1'b0;
            end
            
            if (p) begin
                q <= 1'b1;
            end else begin
                q <= 1'b0;
            end
        end
    end

endmodule
```