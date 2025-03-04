```verilog
module TopModule (
    input logic ring,
    input logic vibrate_mode,
    output logic ringer,
    output logic motor
);

always_comb begin
    if (vibrate_mode) begin
        motor = 1'b1;
        ringer = 1'b0;
    end else begin
        motor = 1'b0;
        ringer = ring;
    end
end

endmodule
```