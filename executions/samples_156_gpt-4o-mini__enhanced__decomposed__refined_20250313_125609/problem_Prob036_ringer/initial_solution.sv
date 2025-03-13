```
[BEGIN]
module TopModule (
    input logic ring,
    input logic vibrate_mode,
    input logic reset,
    output logic ringer,
    output logic motor
);

always @(posedge reset) begin
    if (reset) begin
        ringer <= 1'b0;
        motor <= 1'b0;
    end
end

always @(*) begin
    if (reset) begin
        ringer = 1'b0;
        motor = 1'b0;
    end else begin
        if (ring) begin
            if (vibrate_mode) begin
                ringer = 1'b0;
                motor = 1'b1;
            end else begin
                ringer = 1'b1;
                motor = 1'b0;
            end
        end else begin
            ringer = 1'b0;
            motor = 1'b0;
        end
    end
end

endmodule
[DONE]
```