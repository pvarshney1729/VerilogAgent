```verilog
module TopModule (
    input logic i_ring,
    input logic i_vibrate_mode,
    output logic o_ringer,
    output logic o_motor
);
    always @(*) begin
        o_motor = 1'b0;
        o_ringer = 1'b0;

        if (i_ring) begin
            if (i_vibrate_mode) begin
                o_motor = 1'b1;
            end else begin
                o_ringer = 1'b1;
            end
        end
    end
endmodule
```