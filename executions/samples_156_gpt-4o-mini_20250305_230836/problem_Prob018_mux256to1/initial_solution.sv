```
[BEGIN]
module TopModule (
    input logic [255:0] in,
    input logic [7:0] sel,
    output logic out
);

    always @(*) begin
        if (sel < 8'd256) begin
            out = in[sel];  // Select the appropriate input
        end else begin
            out = 1'b0; // Default behavior for invalid sel
        end
    end

endmodule
[DONE]
```